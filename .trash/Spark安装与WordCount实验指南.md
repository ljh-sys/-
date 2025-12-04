
# 在Ubuntu上安装Spark并完成WordCount实验指南

本指南将详细介绍如何在Ubuntu操作系统上安装Apache Spark，并完成一个经典的WordCount（单词计数）实验。

## 一、 在Ubuntu上安装Spark

Apache Spark运行在Java虚拟机（JVM）之上，因此在安装Spark之前，必须先安装Java。

### 1. 安装Java

我们将安装OpenJDK 11，这是一个稳定且被广泛支持的版本。

**步骤1: 更新软件包列表**

打开终端（Ctrl+Alt+T），执行以下命令：

```bash
sudo apt update
```

**步骤2: 安装OpenJDK 11**

```bash
sudo apt install openjdk-11-jdk -y
```

**步骤3: 验证Java安装**

安装完成后，通过检查Java版本来验证是否安装成功：

```bash
java -version
```

如果看到类似以下的输出，说明Java已成功安装：

```
openjdk version "11.0.22" 2024-01-16
OpenJDK Runtime Environment (build 11.0.22+7-post-Ubuntu-0ubuntu222.04.1)
OpenJDK 64-Bit Server VM (build 11.0.22+7-post-Ubuntu-0ubuntu222.04.1, mixed mode, sharing)
```

### 2. 下载并安装Spark

**步骤1: 下载Spark**

访问 [Apache Spark官方下载页面](https://spark.apache.org/downloads.html)。通常选择预编译好的Hadoop版本即可。

您可以使用 `wget` 命令直接在终端下载。这里以下載Spark 3.5.1为例（请根据官网最新版本调整）：

```bash
wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
```

**步骤2: 解压Spark安装包**

将下载好的压缩包解压到 `/opt` 目录，这是一个常用于存放可选软件包的位置。

```bash
sudo tar -xvzf spark-3.5.1-bin-hadoop3.tgz -C /opt/
```

**步骤3: 配置环境变量**

为了方便地在任何路径下运行Spark命令，需要配置环境变量。

编辑 `~/.bashrc` 文件：

```bash
nano ~/.bashrc
```

在文件的末尾添加以下内容：

```bash
# Spark Environment Variables
export SPARK_HOME=/opt/spark-3.5.1-bin-hadoop3
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
```

> **注意:** 请确保 `SPARK_HOME` 的路径与您解压的Spark目录名完全一致。

保存文件并退出（在 `nano` 中，按 `Ctrl+X`，然后按 `Y`，最后按 `Enter`）。

**步骤4: 使环境变量生效**

执行以下命令，让刚刚的配置立即生效：

```bash
source ~/.bashrc
```

### 3. 验证Spark安装

**启动Spark主节点（Master）**

```bash
start-master.sh
```

执行后，您应该会看到一些日志输出。在浏览器中访问 `http://localhost:8080`，如果能看到Spark的Web UI界面，说明主节点已成功启动。

![Spark Master UI](https://spark.apache.org/docs/latest/img/spark-webui.png)

**启动Spark工作节点（Worker）**

```bash
start-worker.sh spark://<YOUR-HOSTNAME>:7077
```
> **提示:** 将 `<YOUR-HOSTNAME>` 替换为您的实际主机名（可以在终端输入 `hostname` 命令查看）。您也可以在Spark Web UI中找到主节点的URL。

刷新浏览器 `http://localhost:8080`，您应该能在 "Workers" 列表中看到一个已连接的工作节点。

**停止服务**

完成验证后，可以停止Spark服务：
```bash
stop-worker.sh
stop-master.sh
```

## 二、 完成WordCount实验

WordCount是Spark中最经典的入门示例，用于统计文本文件中每个单词出现的次数。

### 1. 准备数据文件

首先，我们需要一个用于分析的文本文件。

在您的主目录下创建一个名为 `input.txt` 的文件：

```bash
nano input.txt
```

在文件中输入以下内容：

```
Hello Spark Hello World
Spark is a fast and general-purpose cluster computing system
Word count is a classic example for Spark
```

保存并退出。

### 2. 使用Spark Shell进行交互式分析

`spark-shell` 提供了一个Scala语言的交互式环境，非常适合进行快速的数据分析和实验。

**步骤1: 启动Spark Shell**

在终端中直接运行：

```bash
spark-shell
```

您将看到Spark的logo和Scala REPL的提示符 `scala>`。

**步骤2: 编写并执行WordCount代码**

在 `scala>` 提示符后，逐行输入以下代码。

**a. 读取输入文件创建RDD**
将文本文件加载成一个弹性分布式数据集（RDD）。

```scala
val textFile = sc.textFile("input.txt")
```

**b. 拆分单词并计数**
这是WordCount的核心逻辑。

```scala
val counts = textFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey(_ + _)
```
代码解释：
- `flatMap(line => line.split(" "))`: 将每一行文本按空格拆分成单词。
- `map(word => (word, 1))`: 将每个单词映射成一个 `(单词, 1)` 的键值对。
- `reduceByKey(_ + _)`: 对相同的键（单词）的值进行累加，实现计数。

**c. 查看部分结果**
您可以在控制台打印出部分结果来验证。

```scala
counts.take(5).foreach(println)
```

**d. 保存结果到文件**
将最终的计数结果保存到一个文件中。Spark会将结果保存在一个名为 `output` 的目录中。

```scala
counts.saveAsTextFile("output")
```
> **注意:** 如果 `output` 目录已存在，此命令会报错。您需要先删除它 (`rm -r output`) 或指定一个新目录。

**步骤3: 退出Spark Shell**
```scala
:q
```

### 3. 查看实验结果

执行完上述步骤后，Spark会在当前目录下创建一个 `output` 文件夹。

**查看目录结构：**

```bash
ls output/
```

您会看到类似 `_SUCCESS` 和 `part-00000` 这样的文件。`_SUCCESS` 是一个标记文件，表示任务成功完成。`part-00000` 存储了计算结果。

**查看结果文件内容：**

```bash
cat output/part-00000
```

输出内容应该如下（顺序可能不同）：

```
(general-purpose,1)
(Hello,2)
(a,2)
(computing,1)
(World,1)
(for,1)
(fast,1)
(is,2)
(example,1)
(count,1)
(and,1)
(cluster,1)
(Spark,3)
(Word,1)
(classic,1)
(system,1)
```

至此，您已成功在Ubuntu上安装了Spark，并完成了经典的WordCount实验。
