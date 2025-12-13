# Gemini CLI 与 MCP 集成指南

本文档旨在阐述 Gemini CLI 如何作为 MCP (模型-上下文-协议) 的客户端，与外部工具服务进行集成和交互。它将深入探讨其背后的配置、发现机制和核心工作流程。

在阅读本文档前，建议先熟悉 `mcp_guide.md` 中关于 MCP 的基本概念。

---

## 1. 核心概念

在 Gemini CLI 与 MCP 的集成中，各个组件扮演着明确的角色：

*   **客户端 (Client)**：**Gemini CLI** 本身。它负责管理 MCP 服务器的配置、向 Gemini 模型声明可用工具、解析模型的工具调用指令，并最终执行这些调用。

*   **服务器 (Server)**：遵循 MCP 协议的外部工具服务。这些服务可以是本地运行的命令行脚本，也可以是远程的 HTTP 端点。

*   **配置文件 (`mcp.json`)**：这是连接 Gemini CLI 与 MCP 服务器的**核心桥梁**。CLI 通过读取此文件来发现所有可用的 MCP 服务及其调用方式。

*   **工作流 (Workflow)**：整个交互是一个闭环。CLI 将用户提示和可用工具列表发送给模型，模型返回工具调用指令，CLI 执行该指令，然后将结果返回给模型以生成最终答复。

---

## 2. 配置文件：`mcp.json`

Gemini CLI 的 MCP 功能完全由一个名为 `mcp.json` 的配置文件驱动。CLI 在启动时会加载此文件，以确定它可以与哪些 MCP 服务器通信。

该文件的位置通常在项目的 `config/` 目录下。

### 2.1 结构与示例

`mcp.json` 的核心是一个 `mcpServers` 对象，其中每个键都是一个服务器的唯一标识符（`server_name`），值则定义了该服务器的配置。

**示例 `mcp.json`:**

```json
{
  "mcpServers": {
    "awslabs.terraform-mcp-server": {
      "type": "command",
      "command": "python",
      "args": [
        "-m",
        "awslabs.mcp.terraform.server"
      ]
    },
    "awslabs.cost-analysis-mcp-server": {
        "type": "url",
        "url": "http://localhost:8081/mcp/cost"
    }
  }
}
```

### 2.2 配置项解析

*   `mcpServers`: 顶层对象，包含了所有 MCP 服务器的定义。
*   **`server_name`** (例如 `"awslabs.terraform-mcp-server"`):
    *   服务器的唯一标识符。
    *   模型在 `<use_mcp_tool>` 语法中通过此名称来指定要调用的服务器。
*   `type`:
    *   `"command"`: 表示该服务器是一个本地应用程序，通过命令行启动。
    *   `"url"`: 表示该服务器是一个远程服务，通过 HTTP(S) 请求访问。
*   `command` (仅当 `type` 为 `command` 时使用):
    *   用于启动服务器进程的可执行文件（例如 `python`, `node`, 或一个二进制文件）。
*   `args` (仅当 `type` 为 `command` 时使用):
    *   一个字符串数组，作为参数传递给 `command`。
*   `url` (仅当 `type` 为 `url` 时使用):
    *   MCP 服务器监听请求的完整 URL。

这个配置机制的实现逻辑可以在 `MCPSettings.load_server_config` 类方法中找到，它负责解析此 JSON 文件并创建相应的 `MCPServerConfig` 对象。

---

## 3. 工作流程详解

下面是当用户通过 Gemini CLI 发出一个需要使用外部工具的请求时，端到端的完整工作流程：

**1. 启动与加载 (Startup and Loading)**
   - Gemini CLI 启动时，会查找并加载 `mcp.json` 文件。
   - 它解析文件内容，将所有定义的 MCP 服务器注册到内部的一个服务目录中。此时，CLI 已经“知道”了所有可用的工具服务器。

**2. 用户输入 (User Input)**
   - 用户向 CLI 提供一个指令，例如：`gemini "为我创建一个名为 'my-test-bucket' 的 S3 存储桶的 Terraform 配置"`。

**3. 构造模型请求 (Constructing the Model Request)**
   - 这是集成的关键步骤。Gemini CLI **不会**简单地将用户的原始提示直接发送给 Gemini 模型。
   - 相反，它会构造一个更复杂的 `LlmRequest` 对象。在此对象中，除了用户的提示外，CLI 还会**注入一个工具列表**，该列表是根据步骤 1 中加载的 MCP 服务器信息动态生成的。
   - 这相当于告诉模型：“除了你的内置能力，你还可以使用以下工具：`awslabs.terraform-mcp-server` 等。”

**4. 模型生成工具调用 (Model Generates a Tool Call)**
   - Gemini 模型接收到包含用户提示和可用工具列表的请求。
   - 它理解用户的意图，并判断需要使用外部工具来完成任务。
   - 因此，模型的**输出不是直接的答案**，而是一个符合 MCP 协议的 `<use_mcp_tool>` XML 块。
   ```xml
   <use_mcp_tool>
       <server_name>awslabs.terraform-mcp-server</server_name>
       <tool_name>GenerateS3BucketResource</tool_name>
       <arguments>
           {
               "bucket_name": "my-test-bucket"
           }
       </arguments>
   </use_mcp_tool>
   ```

**5. CLI 解析并执行 (CLI Parses and Executes)**
   - Gemini CLI 接收到这个 XML 响应。它会识别出这是一个工具调用指令，而不是要直接显示给用户的文本。
   - CLI 解析 XML，提取出 `server_name`、`tool_name` 和 `arguments`。

**6. 与 MCP 服务器通信 (Communicating with the MCP Server)**
   - CLI 在其服务目录中查找 `server_name` (`awslabs.terraform-mcp-server`) 对应的配置。
   - **如果 `type` 是 "command"**：CLI 会执行配置中指定的命令（例如 `python -m awslabs.mcp.terraform.server`），并通过标准输入（stdin）或类似的 IPC 机制将包含 `tool_name` 和 `arguments` 的 JSON 载荷发送给子进程。
   - **如果 `type` 是 "url"**：CLI 会向配置的 `url` 发送一个 HTTP POST 请求，请求体 (body) 是包含 `tool_name` 和 `arguments` 的 JSON 载荷。

**7. 返回结果并完成循环 (Returning the Result and Completing the Loop)**
   - MCP 服务器执行工具逻辑后，将结果（例如生成的 Terraform HCL 代码）作为 JSON 响应返回给 Gemini CLI。
   - CLI 接收到这个结果，并**再次调用 Gemini 模型**。
   - 在这次调用中，CLI 会附加上下文：“这是你刚才调用的工具 `GenerateS3BucketResource` 返回的结果：...（HCL 代码）...。现在，请根据这个结果，为用户生成最终的回答。”

**8. 最终响应 (Final Response)**
   - Gemini 模型接收到工具的输出结果，并基于此生成一个格式良好、对用户友好的最终答案。
   - Gemini CLI 最后将这个答案呈现在用户的终端上。

---

## 4. 总结

Gemini CLI 通过一个简单而强大的 `mcp.json` 配置文件，实现了与 MCP 生态系统的无缝集成。它扮演着一个智能“调度员”的角色：向模型推荐工具、解析模型的工具调用意图、执行工具并返回结果，最终将复杂的任务分解并在模型和外部工具之间协同完成。这种设计极大地增强了 Gemini CLI 的能力，使其从一个简单的模型交互界面演变为一个可无限扩展的智能代理平台。
