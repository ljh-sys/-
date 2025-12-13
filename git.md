# Git 常用命令

## 1. 初始化git本地仓库

```shell
git init
```

## 2. 关联本地仓库和远程仓库

```shell
git remote add origin https://gitee.com/liujiahong528/xzt-web.git
```

## 3. 下拉远程仓库的master分支到本地仓库，然后本地仓库合并远程仓库的分支（拉取并合并不相关历史）（解决冲突）

```shell
git pull origin master --allow-unrelated-histories
```

## 4. 将代码添加到暂存区（解决冲突后提交）

```shell
git add .
```

## 5. 把代码提交到本地仓库

```shell
git commit -m '使用git把代码提交gitee'
```

## 6. 把代码推送到远程仓库

```shell
git push origin master
```

---

## 备选方案：强制覆盖远程仓库（慎用！）

如果确认远程仓库内容无需保留（如测试仓库或初始文件可丢弃），可直接强制推送覆盖：

```shell
git push --force origin master
```

---

## 其它

### 新建分支

```shell
git branch 分支名
```

### 切换分支

```shell
git checkout 分支名
```

### 合并分支（将其它分支合并到当前分支）

```shell
git merge 其它分支
```

### 变基（将当前分支合并到其它分支）

```shell
git rebase 主分支
```

### 第一次提交
```shell
 git push -u origin master
```
  - `git push`: 推送命令。
   - `-u origin master`: 第一次推送时使用此选项，它会将本地的 `master` 分支与远程的 `origin` 仓库的 `master` 分支关联起来，并设置为默认上游分支。之后你就可以直接使用 `git push`。
   - 如果你的远程仓库是 `main` 分支，请使用 `git push -u origin main`。