# Linux 命令大全 

## 前言

本指南旨在为 Linux 新手提供一份清晰、详细且易于理解的常用命令参考。每个命令都包含功能说明、常用示例和关键选项解析，希望能帮助你快速上手 Linux。Linux 命令是大小写敏感的，请注意区分。

---

## 目录

1.  [文件和目录管理](Linux命令大全.md#1-文件和目录管理)
2.  [文本处理](Linux命令大全.md#2-文本处理)
3.  [系统管理和监控](Linux命令大全.md#3-系统管理和监控)
4.  [网络命令](Linux命令大全.md#4-网络命令)
5.  [权限管理](Linux命令大全.md#5-权限管理)
6.  [文件搜索](Linux命令大全.md#6-文件搜索)
7.  [打包与压缩](Linux命令大全.md#7-打包与压缩)
8.  [其他常用命令](Linux命令大全.md#8-其他常用命令)

---

## 1. 文件和目录管理

### `ls` - 列出文件和目录
*   **功能**: 列出当前目录或指定目录中的文件和子目录。
*   **常用示例**:
    ```bash
    # 列出当前目录的内容
    ls

    # 以长格式（详细信息）列出内容
    ls -l

    # 列出所有文件，包括隐藏文件（以.开头的文件）
    ls -a

    # 结合使用，以人类可读的格式显示所有文件的详细信息
    ls -lah
    ```
*   **关键选项**:
    *   `-l`: (long) 使用长格式显示，包含权限、所有者、大小、修改日期等详细信息。
    *   `-a`: (all) 显示所有文件，包括以 `.` 开头的隐藏文件。
    *   `-h`: (human-readable) 配合 `-l` 使用，以易于阅读的格式显示文件大小（如 `K`, `M`, `G`）。
    *   `-t`: 按修改时间排序，最新的排在最前面。

### `cd` - 切换目录
*   **功能**: 更改当前工作目录。
*   **常用示例**:
    ```bash
    # 进入名为 'documents' 的子目录
    cd documents

    # 返回上一级目录
    cd ..

    # 快速返回主目录 (home directory)
    cd ~
    # 或者直接
    cd

    # 返回到你上一次所在的目录
    cd -
    ```

### `pwd` - 显示当前目录
*   **功能**: 打印当前工作目录的完整路径。
*   **常用示例**:
    ```bash
    # 显示你当前在哪个目录
    pwd
    # 输出示例: /home/username/documents
    ```

### `mkdir` - 创建目录
*   **功能**: 创建一个新的目录。
*   **常用示例**:
    ```bash
    # 在当前位置创建一个名为 'new_folder' 的目录
    mkdir new_folder

    # 递归创建目录，即使父目录不存在也能成功
    mkdir -p project/src/components
    ```
*   **关键选项**:
    *   `-p`: (parents) 确保父目录存在，如果不存在则一并创建，非常实用。

### `rm` - 删除文件或目录
*   **功能**: 删除文件或目录。**这是一个危险的命令，删除后通常无法恢复，请谨慎使用！**
*   **常用示例**:
    ```bash
    # 删除一个名为 'old_file.txt' 的文件
    rm old_file.txt

    # 强制删除一个文件，不进行提示
    rm -f sensitive_data.txt

    # 递归删除一个目录及其所有内容（非常危险！）
    rm -r old_project

    # 强制递归删除，不进行任何提示（极度危险！）
    rm -rf old_project
    ```
*   **关键选项**:
    *   `-r` 或 `-R`: (recursive) 递归删除目录及其内容。删除目录时必须使用。
    *   `-f`: (force) 强制删除，忽略不存在的文件，不给出提示。
    *   `-i`: (interactive) 在每次删除前给出提示，增加安全性。

### `cp` - 复制文件或目录
*   **功能**: 复制文件或目录。
*   **常用示例**:
    ```bash
    # 将 file1.txt 复制为 file2.txt
    cp file1.txt file2.txt

    # 将 file1.txt 复制到 'backup' 目录中
    cp file1.txt backup/

    # 递归复制整个目录
    cp -r my_project archives/
    ```
*   **关键选项**:
    *   `-r` 或 `-R`: 递归复制整个目录及其内容。
    *   `-i`: 如果目标文件已存在，在覆盖前提示。

### `mv` - 移动或重命名
*   **功能**: 移动文件或目录，或者给它们重命名。
*   **常用示例**:
    ```bash
    # 将文件重命名
    mv old_name.txt new_name.txt

    # 将文件移动到另一个目录
    mv report.pdf documents/

    # 将'my_app'目录移动到'/opt'下并重命名为'my_app_v2'
    mv my_app /opt/my_app_v2
    ```

### `touch` - 创建空文件或更新时间戳
*   **功能**: 如果文件不存在，则创建一个空的该文件；如果文件已存在，则更新其访问和修改时间。
*   **常用示例**:
    ```bash
    # 创建一个名为 'new_file.md' 的空文件
    touch new_file.md
    ```

---

## 2. 文本处理

### `cat` - 查看文件内容
*   **功能**: 读取文件内容并将其显示在终端上。适合查看小文件。
*   **常用示例**:
    ```bash
    # 查看文件内容
    cat config.txt

    # 合并多个文件并显示
    cat file1.txt file2.txt

    # 合并多个文件并输出到新文件
    cat file1.txt file2.txt > combined.txt
    ```

### `less` - 分页查看文件内容
*   **功能**: 以可交互的方式分页查看大文件内容。比 `more` 更强大。
*   **常用示例**:
    ```bash
    # 查看大日志文件
    less large_log_file.log
    ```
*   **交互操作**:
    *   `空格键` 或 `f`: 向下翻一页。
    *   `b`: 向上翻一页。
    *   `/关键字`: 向下搜索关键字。
    *   `n`: 定位到下一个搜索结果。
    *   `q`: 退出查看。

### `head` / `tail` - 查看文件头部/尾部
*   **功能**: `head` 用于显示文件开头几行，`tail` 用于显示文件末尾几行。
*   **常用示例**:
    ```bash
    # 显示文件的前10行（默认）
    head filename.txt

    # 显示文件的前5行
    head -n 5 filename.txt

    # 显示文件的末尾10行（默认）
    tail filename.txt

    # 持续监控文件末尾的新增内容（常用于看日志）
    tail -f /var/log/syslog
    ```
*   **关键选项**:
    *   `-n <行数>`: 指定显示的行数。
    *   `-f`: (follow) 持续跟踪文件的新增内容。按 `Ctrl+C` 停止。

### `grep` - 搜索文本
*   **功能**: 在文件或输入流中搜索包含指定模式的行。
*   **常用示例**:
    ```bash
    # 在文件中搜索包含 "error" 的行
    grep "error" application.log

    # 在所有.java文件中忽略大小写搜索 "user"
    grep -i "user" *.java

    # 显示不包含 "debug" 的行
    grep -v "debug" application.log

    # 递归搜索目录中所有包含 "API_KEY" 的文件
    grep -r "API_KEY" /etc/
    ```
*   **关键选项**:
    *   `-i`: (ignore case) 忽略大小写。
    *   `-v`: (invert match)反转匹配，只显示不匹配的行。
    *   `-r`: (recursive) 递归搜索目录。
    *   `-n`: 显示匹配行的行号。

---

## 3. 系统管理和监控

### `ps` - 查看进程
*   **功能**: 显示当前系统中正在运行的进程。
*   **常用示例**:
    ```bash
    # 显示当前用户的所有进程
    ps

    # 显示系统上所有进程的详细信息（BSD风格）
    ps aux

    # 显示系统上所有进程的详细信息（System V风格）
    ps -ef

    # 配合 grep 查找特定进程，例如 ssh
    ps aux | grep ssh
    ```
*   **关键选项**:
    *   `aux`: 显示所有用户（a）、包括没有终端的进程（x）的详细信息（u）。
    *   `-ef`: 显示所有进程（-e）的完整格式（-f）。

### `top` - 实时监控系统
*   **功能**: 实时动态地显示系统资源使用情况和进程信息。
*   **常用示例**:
    ```bash
    # 启动 top
    top
    ```
*   **交互操作**:
    *   `P`: 按 CPU 使用率排序。
    *   `M`: 按内存使用率排序。
    *   `k`: 杀掉一个进程（会提示输入进程ID）。
    *   `q`: 退出。

### `kill` - 终止进程
*   **功能**:向进程发送信号，通常用于终止进程。
*   **常用示例**:
    ```bash
    # 找到进程ID (PID)
    ps aux | grep nginx
    # 假设找到的PID是 1234

    # 优雅地终止进程
    kill 1234

    # 强制杀死进程（当正常终止无效时）
    kill -9 1234
    ```
*   **关键选项**:
    *   `-9`: 发送 `SIGKILL` 信号，强制立即终止进程。

### `df` / `du` - 查看磁盘空间
*   **功能**:
    *   `df`: (disk free) 显示文件系统的磁盘空间使用情况。
    *   `du`: (disk usage) 显示文件或目录占用的磁盘空间大小。
*   **常用示例**:
    ```bash
    # 以易读格式显示所有文件系统的空间使用情况
    df -h

    # 以易读格式查看当前目录的总大小
    du -sh .

    # 以易读格式查看 'documents' 目录及子目录的大小
    du -h documents
    ```
*   **关键选项**:
    *   `-h`: (human-readable) 以 K, M, G 等易读单位显示。
    *   `-s`: (summarize) `du` 命令专用，只显示总计大小。

---

## 4. 网络命令

### `ping` - 测试网络连通性
*   **功能**: 向目标主机发送ICMP报文，测试网络是否通畅以及延迟。
*   **常用示例**:
    ```bash
    # 测试与 google.com 的连通性
    ping google.com

    # 只发送5个包后停止
    ping -c 5 google.com
    ```

### `ifconfig` / `ip addr` - 查看网络接口
*   **功能**: 显示或配置网络接口信息。`ip addr` 是 `ifconfig` 的现代替代品。
*   **常用示例**:
    ```bash
    # 显示所有网络接口信息（旧式）
    ifconfig

    # 显示所有网络接口信息（新式）
    ip addr show
    ```

### `ssh` - 安全远程登录
*   **功能**: 通过加密的方式远程连接到另一台Linux服务器。
*   **常用示例**:
    ```bash
    # 以 user 用户名连接到远程主机
    ssh user@remote_host_ip

    # 指定端口号连接
    ssh -p 2222 user@remote_host_ip
    ```

### `wget` / `curl` - 从网络下载文件
*   **功能**: 强大的命令行下载工具。`curl` 功能更丰富，还能用于API测试。
*   **常用示例**:
    ```bash
    # 使用 wget 下载文件
    wget https://example.com/file.zip

    # 使用 curl 下载文件并保存为指定名称
    curl -o newfile.zip https://example.com/file.zip

    # 使用 curl 查看网页内容
    curl https://example.com

    # 使用 curl 测试API
    curl -X POST -d '{"key":"value"}' https://api.example.com/submit
    ```

---

## 5. 权限管理

### `chmod` - 修改文件权限
*   **功能**: 更改文件或目录的访问权限。
*   **权限说明**: 权限分为读(r=4), 写(w=2), 执行(x=1)。分别对应所有者(u), 所属组(g), 其他人(o)。
*   **常用示例**:
    ```bash
    # 数字模式：
    # 给 my_script.sh 添加执行权限 (rwx r-x r-x)
    # 所有者: rwx = 4+2+1=7
    # 所属组: r-x = 4+0+1=5
    # 其他人: r-x = 4+0+1=5
    chmod 755 my_script.sh

    # 字符模式：
    # 为所有者添加执行权限
    chmod u+x my_script.sh

    # 为所有人移除写权限
    chmod a-w sensitive.txt

    # 递归地为目录及其中所有文件设置权限
    chmod -R 755 my_project/
    ```

### `chown` - 修改文件所有者
*   **功能**: 更改文件或目录的所有者和所属组。
*   **常用示例**:
    ```bash
    # 将文件所有者改为 'new_user'
    chown new_user file.txt

    # 同时更改所有者和所属组
    chown new_user:new_group file.txt

    # 递归更改目录的所有权
    chown -R new_user:new_group /var/www/html
    ```

---

## 6. 文件搜索

### `find` - 查找文件
*   **功能**: 在指定目录树中按条件搜索文件。功能强大但语法复杂。
*   **常用示例**:
    ```bash
    # 在当前目录及子目录中按名称查找文件
    find . -name "config.ini"

    # 在 /home 目录中查找所有 .log 文件（名称不区分大小写）
    find /home -iname "*.log"

    # 查找大于100MB的文件
    find . -size +100M

    # 查找最近7天内被修改过的文件
    find . -mtime -7
    ```

### `locate` - 快速查找文件
*   **功能**: 基于数据库快速查找文件。比 `find` 快得多，但可能不是最新的。
*   **常用示例**:
    ```bash
    # 查找所有包含 'httpd' 的文件
    locate httpd.conf

    # 更新 locate 使用的数据库（需要管理员权限）
    sudo updatedb
    ```

---

## 7. 打包与压缩

### `tar` - 打包和解包
*   **功能**: 将多个文件或目录打包成一个 `.tar` 文件，或从中解包。常与压缩命令结合使用。
*   **常用示例**:
    ```bash
    # 打包并使用 gzip 压缩 (生成 .tar.gz)
    # c: create, z: gzip, v: verbose, f: file
    tar -czvf archive.tar.gz folder_to_compress/

    # 解压并解包 .tar.gz 文件
    # x: extract
    tar -xzvf archive.tar.gz

    # 打包并使用 bzip2 压缩 (生成 .tar.bz2)
    tar -cjvf archive.tar.bz2 folder/

    # 解压并解包 .tar.bz2 文件
    tar -xjvf archive.tar.bz2
    ```

### `zip` / `unzip` - ZIP格式压缩与解压
*   **功能**: 创建和解压 `.zip` 格式的压缩文件。
*   **常用示例**:
    ```bash
    # 压缩目录
    zip -r archive.zip my_folder/

    # 解压文件
    unzip archive.zip

    # 解压到指定目录
    unzip archive.zip -d /path/to/destination
    ```

---

## 8. 其他常用命令

### `man` - 查看命令手册
*   **功能**: 显示命令的帮助手册，这是最权威的学习资料。
*   **常用示例**:
    ```bash
    # 查看 ls 命令的手册
    man ls
    ```

### `history` - 查看历史命令
*   **功能**: 显示你在当前终端会话中执行过的历史命令。
*   **常用示例**:
    ```bash
    # 显示所有历史命令
    history

    # 执行历史记录中的第100条命令
    !100
    ```

### `clear` - 清屏
*   **功能**: 清除终端屏幕上的所有内容。
*   **快捷键**: `Ctrl + L` 也能达到同样效果。

### `sudo` - 以管理员权限执行
*   **功能**: (superuser do) 允许普通用户以管理员（root）的身份执行命令。
*   **常用示例**:
    ```bash
    # 以管理员身份更新软件包列表
    sudo apt update

    # 以管理员身份编辑受保护的文件
    sudo nano /etc/hosts
    ```
