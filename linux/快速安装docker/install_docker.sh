
#!/bin/bash

# 1. 卸载旧版本的 Docker
echo "卸载旧版本 Docker..."
apt-get remove -y docker docker-engine docker.io containerd runc

# 2. 更新软件包
echo "更新软件包列表..."
apt update && apt upgrade -y

# 3. 安装 Docker 依赖
echo "安装 Docker 依赖..."
apt-get install -y ca-certificates curl gnupg lsb-release

# 4. 添加 Docker 官方 GPG 密钥
echo "添加 Docker 官方 GPG 密钥..."
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# 5. 添加 Docker 软件源
echo "添加 Docker 软件源..."
add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 6. 安装 Docker
echo "安装 Docker..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# 7. 配置 Docker 用户组（可选）
echo "将当前用户添加到 Docker 组..."
usermod -aG docker $USER

# 8. 启动 Docker 服务
echo "启动 Docker 服务..."
systemctl start docker

# 9. 安装工具
echo "安装 Docker 工具..."
apt-get -y install apt-transport-https ca-certificates curl software-properties-common

# 10. 配置国内仓库
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://docker.xuanyuan.me"]
}
EOF

# 11. 重启 Docker 服务
echo "重启 Docker 服务..."
service docker restart

# 提示安装完成
echo "Docker 安装和配置完成！"
