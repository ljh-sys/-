# MCP (模型-上下文-协议) 指南

本文档旨在全面介绍 MCP (Model-Context-Protocol)，包括其基本概念、使用方法、现有服务生态以及如何开发自定义的 MCP 服务。

---

## 1. 什么是 MCP？

**MCP (Model-Context-Protocol)** 是一种专为大型语言模型（LLM）设计的、标准化的客户端-服务器架构协议。它的核心目标是允许模型（客户端）与外部的、具备专门技能的工具（服务器）进行交互，从而极大地扩展模型自身的能力范围。

想象一下，一个核心的智能模型（如 Gemini）是“大脑”，而各个 MCP 服务则是拥有特定技能的“专家之手”。当“大脑”接到一个超出其核心知识范围的复杂任务时（例如，“查询最新的 AWS 服务价格”、“根据需求生成一段 Terraform 代码”或“分析一个 PDF 文档”），它可以通过 MCP 协议，将任务委托给相应的“专家”去处理，并接收结果。

**核心特点：**

*   **模块化与可扩展性**：每个 MCP 服务都是一个独立的单元，可以独立开发、部署和更新，而无需改动核心模型。
*   **专业化**：允许开发者创建针对特定领域（如云计算、数据库、代码分析、图像生成等）的高度优化的工具。
*   **标准化交互**：通过统一的语法（通常是类 XML 格式）进行调用，降低了模型学习使用新工具的成本。
*   **松耦合**：模型与工具之间是松耦合关系，可以通过网络 `url` 或本地 `command` 等多种方式连接。

---

## 2. 如何使用 MCP？

模型通过一种被称为 `use_mcp_tool` 的特殊语法来调用 MCP 服务。这种语法通常嵌入在模型的思考过程或最终输出中，由外层框架解析并执行。

其标准结构如下：

```xml
<use_mcp_tool>
    <server_name>服务器的唯一标识符</server_name>
    <tool_name>要调用的工具名称</tool_name>
    <arguments>
        {
            "参数名1": "参数值1",
            "参数名2": "参数值2"
        }
    </arguments>
</use_mcp_tool>
```

**语法解析：**

*   `<server_name>`：必需。指定要通信的 MCP 服务器。每个服务器都有一个唯一的名称，例如 `awslabs.core-mcp-server` 或 `awslabs.terraform-mcp-server`。
*   `<tool_name>`：必需。指定该服务器上要执行的具体工具（函数）。例如 `prompt_understanding` 或 `SearchAwsccProviderDocs`。
*   `<arguments>`：必需。一个 JSON 对象，包含了调用该工具所需的所有参数。如果工具不需要参数，可以是一个空对象 `{}`。

---

## 3. 探索现有的 MCP 服务

生态系统中有许多现成的 MCP 服务可供使用，以下列举了一些来自 `awslabs` 的示例，以展示 MCP 的多样化能力。

### 3.1 核心能力 (awslabs.core-mcp-server)

用于执行一些基础但强大的核心任务，例如理解用户意图。

```xml
<!-- 理解用户需求 -->
<use_mcp_tool>
    <server_name>awslabs.core-mcp-server</server_name>
    <tool_name>prompt_understanding</tool_name>
    <arguments>
        {}
    </arguments>
</use_mcp_tool>
```

### 3.2 知识库检索 (awslabs.bedrock-kb-retrieval-mcp-server)

用于从指定的知识库中检索信息。

```xml
<!-- 查询知识库 -->
<use_mcp_tool>
    <server_name>awslabs.bedrock-kb-retrieval-mcp-server</server_name>
    <tool_name>QueryKnowledgeBases</tool_name>
    <arguments>
        {
            "query": "what services are allowed internally on aws",
            "knowledge_base_id": "KBID",
            "number_of_results": 10
        }
    </arguments>
</use_mcp_tool>
```

### 3.3 AWS CDK 指导 (awslabs.cdk-mcp-server)

提供关于 AWS Cloud Development Kit (CDK) 的架构建议。

```xml
<!-- 获取 CDK 基础设施指导 -->
<use_mcp_tool>
    <server_name>awslabs.cdk-mcp-server</server_name>
    <tool_name>CDKGeneralGuidance</tool_name>
    <arguments>
        {}
    </arguments>
</use_mcp_tool>
```

### 3.4 Terraform 集成 (awslabs.terraform-mcp-server)

用于执行 Terraform 命令或搜索其文档。

```xml
<!-- 搜索 AWSCC 提供商的文档 -->
<use_mcp_tool>
    <server_name>awslabs.terraform-mcp-server</server_name>
    <tool_name>SearchAwsccProviderDocs</tool_name>
    <arguments>
        {
            "asset_name": "awscc_lambda_function",
            "asset_type": "resource"
        }
    </arguments>
</use_mcp_tool>
```

### 3.5 图像生成 (awslabs.nova-canvas-mcp-server)

根据文本提示生成图像，常用于创建架构图。

```xml
<!-- 生成架构图 -->
<use_mcp_tool>
    <server_name>awslabs.nova-canvas-mcp-server</server_name>
    <tool_name>generate_image</tool_name>
    <arguments>
        {
            "prompt": "3D isometric view of AWS cloud architecture with Lambda functions, API Gateway, and DynamoDB tables, professional technical diagram style",
            "width": 1024,
            "height": 1024
        }
    </arguments>
</use_mcp_tool>
```

---

## 4. 如何开发自己的 MCP 服务

开发自己的 MCP 服务通常涉及以下几个步骤。这里我们以 Python 为例，基于 `FastMCP` 框架进行演示。

### 步骤 1: 创建工具类

首先，定义一个 Python 类，它将包含你希望作为工具暴露给模型的方法。

```python
# my_metrics_tool.py

class MetricsTool:
    def __init__(self, mcp: FastMCP):
        """
        初始化工具，并通过 mcp.tool() 注册方法。
        """
        mcp.tool(name='get_metrics')(self.get_metrics)

    def get_metrics(self, server_load: float, user_count: int) -> dict:
        """
        一个简单的示例工具，用于计算和返回一些虚构的指标。
        
        Args:
            server_load: 服务器负载值。
            user_count: 当前用户数。
            
        Returns:
            一个包含计算后指标的字典。
        """
        print(f"接收到参数: server_load={server_load}, user_count={user_count}")
        
        # 实际的业务逻辑
        adjusted_load = server_load * 1.1
        projected_users = user_count + 100
        
        return {
            "status": "success",
            "adjusted_load": adjusted_load,
            "projected_users": projected_users,
            "message": "Metrics calculated successfully."
        }

```

### 步骤 2: 注册工具

在类的 `__init__` 方法中，接收一个 `FastMCP` 实例。然后，使用 `mcp.tool(name='...')` 来装饰或包装你想要暴露的方法。`name` 参数就是模型在 `<tool_name>` 标签中使用的名字。

如上例所示：
`mcp.tool(name='get_metrics')(self.get_metrics)`

### 步骤 3: 配置 MCP 服务器

为了让 MCP 框架能够找到并运行你的服务，你需要在一个全局的配置文件（例如 `mcp.json`）中定义它。

```json
{
    "mcpServers": {
        "my.custom.metrics-server": {
            "type": "command",
            "command": "python",
            "args": [
                "-m",
                "path.to.my_metrics_tool"
            ]
        }
    }
}
```

**配置解析：**

*   `my.custom.metrics-server`：这是服务器的唯一标识符（`<server_name>`）。
*   `type`: "command" 表示这是一个通过命令行启动的本地服务。其他类型可以是 "url"（用于HTTP服务）。
*   `command`: 启动服务的可执行文件。
*   `args`: 传递给命令的参数列表。这里 `-m` 表示以模块方式运行 Python 脚本。

### 步骤 4: 运行和调用

当框架配置好后，它就能根据 `<server_name>` 找到对应的配置，启动服务，并将 `<arguments>` 中的 JSON 对象作为参数传递给你注册的工具函数。

例如，当模型生成以下调用时：

```xml
<use_mcp_tool>
    <server_name>my.custom.metrics-server</server_name>
    <tool_name>get_metrics</tool_name>
    <arguments>
        {
            "server_load": 0.85,
            "user_count": 1500
        }
    </arguments>
</use_mcp_tool>
```

MCP 框架会自动执行以下操作：
1.  查找名为 `my.custom.metrics-server` 的配置。
2.  执行命令 `python -m path.to.my_metrics_tool` 来启动服务。
3.  调用服务中的 `get_metrics` 工具。
4.  将 `{"server_load": 0.85, "user_count": 1500}` 作为关键字参数传递给 `get_metrics` 方法。
5.  方法执行后返回的字典将被传回给模型。

---

## 5. 总结

MCP 协议通过提供一个标准化的、可扩展的框架，极大地增强了语言模型的能力。它使得模型不仅能“思考”，还能借助外部工具“行动”，从而解决更广泛、更复杂的现实世界问题。无论是使用现有的丰富生态，还是开发满足特定需求的自定义工具，MCP 都为下一代 AI 应用的开发铺平了道路。
