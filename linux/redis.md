# Redis Docker 运行命令

```shell
docker run -d \
  --name redis-admin \
  --network app-net \
  -p 6379:6379 \
  redis:latest
```