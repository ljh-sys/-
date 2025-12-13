# Ubuntu 安装 Docker

## 1. 卸载旧版本 Docker

```shell
sudo apt-get remove docker docker-engine docker.io containerd runc
```

## 2. 更新软件包

```shell
sudo apt update
sudo apt upgrade
```

## 3. 安装 Docker 依赖

```shell
sudo apt-get install ca-certificates curl gnupg lsb-release
```

## 4. 添加 Docker 官方 GPG 密钥

```shell
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
```

## 5. 添加 Docker 软件源

```shell
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
```

## 6. 安装 Docker

```shell
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## 7. 配置用户组（可选）

```shell
sudo usermod -aG docker $USER
```

## 8. 运行 Docker

```shell
sudo systemctl start docker
```

## 9. 安装工具

```shell
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
```

## 10. 重启 Docker

```shell
sudo service docker restart
```

## 11. 验证是否成功（拉取 hello-world）

```shell
sudo docker run hello-world
```

## 12. 查看 Docker 版本

```shell
docker version
```

## 13. 查看镜像

```shell
docker images
```

---

> 修改 root 密码：`sudo passwd root`
