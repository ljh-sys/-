# Git 使用指南

## 1. 如何下载 Git

Git 可以在其官方网站下载并安装。

1.  **访问官网**: 打开浏览器，访问 [Git 官方下载页面](https://git-scm.com/downloads)。
2.  **选择操作系统**: 根据你的操作系统（Windows, macOS, Linux）选择对应的下载链接。
    *   **Windows**: 点击 "Windows" 链接，下载最新版本的 Git for Windows 安装程序，然后按照安装向导的指示进行安装。
    *   **macOS**: 可以通过 Homebrew 安装 (推荐): 在终端中运行 `brew install git`。如果没有 Homebrew，可以下载官方提供的安装程序。
    *   **Linux**: 大多数 Linux 发行版都可以通过其包管理器安装 Git。
        *   Debian/Ubuntu: `sudo apt update && sudo apt install git`
        *   Fedora: `sudo dnf install git`
        *   CentOS/RHEL: `sudo yum install git` (较旧版本) 或 `sudo dnf install git` (较新版本)
3.  **验证安装**: 安装完成后，打开终端或命令提示符，输入 `git --version`，如果显示 Git 的版本号，则表示安装成功。

## 2. 如何在 Git 中创建仓库

通常，你会在本地创建一个 Git 仓库，然后将其关联到远程仓库（如 GitHub、GitLab 或 Gitee）。

### 2.1 初始化本地仓库

1.  **打开终端/命令提示符**: 导航到你想要创建仓库的项目文件夹。
    ```bash
    cd /path/to/your/project
    ```
2.  **初始化 Git**: 在项目文件夹中运行以下命令，初始化一个新的 Git 仓库。
    ```bash
    git init
    ```
    这会在你的项目文件夹中创建一个 `.git` 隐藏目录，用于存储 Git 仓库的所有信息。

### 2.2 关联远程仓库 (可选，但推荐)

如果你想将本地仓库与远程仓库同步，你需要关联一个远程仓库。

1.  **在远程平台创建仓库**: 在 GitHub、GitLab 或 Gitee 等平台创建一个新的空仓库，通常会提供一个远程仓库的 URL (例如 `https://github.com/your-username/your-repo.git`)。
2.  **添加远程仓库**: 在本地仓库的终端中，运行以下命令关联远程仓库。将 `YOUR_REMOTE_URL` 替换为你的远程仓库 URL。
    ```bash
    git remote add origin YOUR_REMOTE_URL
    ```
    `origin` 是远程仓库的默认别名。

## 3. 如何将本地 Markdown 格式笔记上传到仓库的 `master` 分支

`master` 分支是传统的默认主分支。现在很多新项目默认使用 `main` 分支。请根据你的仓库实际情况替换为 `master` 或 `main`。

1.  **检查文件状态**: 确保你的 Markdown 笔记文件已经放在本地 Git 仓库的目录下。
    ```bash
    git status
    ```
    这将显示哪些文件是未跟踪的、已修改的或已暂存的。

2.  **添加文件到暂存区**: 将你的 Markdown 笔记文件添加到 Git 的暂存区。
    ```bash
    git add your_note.md
    # 或者添加所有新文件和修改过的文件
    git add .
    ```

3.  **提交更改**: 将暂存区的文件提交到本地仓库。
    ```bash
    git commit -m "Add initial markdown notes"
    ```
    `-m` 后面的字符串是本次提交的描述信息。

4.  **推送到远程仓库**: 将本地仓库的更改推送到远程仓库的 `master` 分支。
    ```bash
    git push -u origin master
    ```
    *   `git push`: 推送命令。
    *   `-u origin master`: 第一次推送时使用此选项，它会将本地的 `master` 分支与远程的 `origin` 仓库的 `master` 分支关联起来，并设置为默认上游分支。之后你就可以直接使用 `git push`。
    *   如果你的远程仓库是 `main` 分支，请使用 `git push -u origin main`。

完成以上步骤后，你的本地 Markdown 笔记就会被上传到远程仓库的 `master` (或 `main`) 分支。
