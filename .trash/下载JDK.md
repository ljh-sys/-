# 如何下载和安装 Java Development Kit (JDK)

Java Development Kit (JDK) 是用于开发 Java 应用程序的软件开发环境。它包含了 Java 编译器 (javac)、Java 运行时环境 (JRE) 以及其他开发工具。

## 1. 选择你的 JDK 版本和发行商

主要有两种常见的 JDK 发行商：

*   **Oracle JDK**: 官方推荐，但有商业使用限制。
*   **OpenJDK**: 开源免费，有多个发行版，如 Adoptium (Eclipse Adoptium, 以前的 AdoptOpenJDK)。

对于大多数个人开发和学习，**OpenJDK** 是一个很好的选择。

## 2. 下载 JDK

### 选项 A: 从 Oracle 官网下载 (Oracle JDK)

1.  访问 Oracle JDK 下载页面：[https://www.oracle.com/java/technologies/downloads/](https://www.oracle.com/java/technologies/downloads/)
2.  在页面上选择你需要的 **Java 版本** (例如 Java 21, Java 17 LTS)。
3.  滚动到下方找到针对你操作系统的 **下载链接** (例如 Windows x64 Installer)。
4.  点击下载链接。你可能需要登录或注册 Oracle 账户才能下载。
5.  仔细阅读并接受许可协议。

### 选项 B: 从 Adoptium 下载 (OpenJDK)

Adoptium (以前的 AdoptOpenJDK) 提供了免费、高质量的 OpenJDK 发行版。

1.  访问 Adoptium 官网：[https://adoptium.net/temurin/releases/](https://adoptium.net/temurin/releases/)
2.  在页面上选择你需要的 **Java 版本** (推荐选择 LTS 版本，如 Java 17 或 Java 21)。
3.  选择你的 **操作系统** (Operating System) 和 **架构** (Architecture)。
4.  选择 **JDK** (而不是 JRE)。
5.  点击下载按钮。通常会下载一个 `.msi` (Windows) 或 `.tar.gz` (Linux/macOS) 文件。

## 3. 安装 JDK

### Windows

1.  如果你下载的是 `.msi` 安装包，双击运行安装程序。
2.  按照安装向导的指示进行操作，可以选择安装路径（建议使用默认路径）。
3.  安装完成后，通常会自动配置环境变量。

### macOS

1.  如果你下载的是 `.pkg` 安装包，双击运行安装程序，按照指示完成安装。
2.  如果你下载的是 `.tar.gz` 文件，你需要手动解压到你希望安装的目录，例如 `/Library/Java/JavaVirtualMachines/`。
    ```bash
    tar -xzf <下载的tar.gz文件名> -C /Library/Java/JavaVirtualMachines/
    ```

### Linux

1.  如果你下载的是 `.deb` (Debian/Ubuntu) 或 `.rpm` (Red Hat/CentOS) 包，可以使用包管理器安装。
    *   Debian/Ubuntu: `sudo dpkg -i <下载的deb文件名>`
    *   Red Hat/CentOS: `sudo rpm -i <下载的rpm文件名>`
2.  如果你下载的是 `.tar.gz` 文件，你需要手动解压到你希望安装的目录，例如 `/usr/local/java/`。
    ```bash
    sudo mkdir -p /usr/local/java
    sudo tar -xzf <下载的tar.gz文件名> -C /usr/local/java/
    ```

## 4. 配置环境变量 (如果未自动配置)

正确配置环境变量至关重要，它允许你在命令行中运行 Java 命令。

### Windows

1.  搜索 "环境变量"，打开 "编辑系统环境变量"。
2.  点击 "环境变量..." 按钮。
3.  在 "系统变量" 部分：
    *   **新建** `JAVA_HOME` 变量，其值为你的 JDK 安装路径 (例如 `C:\Program Files\Java\jdk-17.0.x`)。
    *   找到 `Path` 变量，**编辑** 它，添加 `%JAVA_HOME%\bin` 到列表。

### macOS/Linux

1.  打开你的终端配置文件，例如 `~/.bashrc`, `~/.zshrc`, 或 `~/.profile`。
2.  在文件末尾添加以下行 (请将路径替换为你的实际 JDK 安装路径)：
    ```bash
    export JAVA_HOME=/usr/local/java/jdk-17.0.x # 替换为你的 JDK 路径
    export PATH=$JAVA_HOME/bin:$PATH
    ```
3.  保存文件并执行 `source ~/.bashrc` (或你修改的文件) 使更改生效。

## 5. 验证安装

打开命令行或终端，输入以下命令来验证 JDK 是否成功安装：

```bash
java -version
javac -version
```

如果安装成功，你将看到类似以下的输出：

```
java version "17.0.x" 202x-xx-xx LTS
Java(TM) SE Runtime Environment (build 17.0.x+x-LTS)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.x+x-LTS, mixed mode, sharing)

javac 17.0.x
```

恭喜！你已经成功下载并安装了 JDK。现在你可以开始编写和运行 Java 应用程序了。
