# Docker 初始化 MySQL

## 1. 下载 MySQL 最新镜像

```shell
docker pull mysql
```

## 2. 启动并初始化 MySQL

```shell
docker run -d --name mysql-admin -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=xzt mysql:latest
```

> **参数说明:**
>
> *   `--name mysql-admin`: 容器名称
> *   `-e MYSQL_ROOT_PASSWORD=123456`: root 密码
> *   `-e MYSQL_DATABASE=xzt`: 新建数据库 xzt

## 3. 登录 MySQL

```shell
docker exec -it mysql-admin mysql -u root -p
```

> (然后再输入密码)

## 4. 查看数据库

```sql
show databases;
```
