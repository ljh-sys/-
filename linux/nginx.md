# Nginx 安装与配置

## 1. Linux 下安装 Nginx

```shell
apt install nginx -y
```

## 2. 验证安装

```shell
nginx -v
```

## 3. 修改配置文件

```shell
vi /etc/nginx/nginx.conf
```

> (根据实际目录)

---

### Nginx 配置文件示例

```nginx
user  root;
worker_processes  1;
#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    # 开启之后访问速度会变快
    #gzip  on;

    server {
        listen       80;
        server_name  localhost;
        root /home/ljh/xzt/dist;
        location / {
            index  index.html index.htm;
            try_files $uri $uri/ /index.html;
        }
    }
}
```

---

## 4. 更新 Nginx 配置文件

```shell
nginx -s reload
```

## 5. 重启 Nginx 服务

```shell
systemctl start nginx
```
