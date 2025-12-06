# WSL (Windows Subsystem for Linux)

## 参考链接

[https://blog.csdn.net/Natsuago/article/details/145594631](https://blog.csdn.net/Natsuago/article/details/145594631)

按照他的操作完成之后，为了方便启动虚拟机，再桌面新建一个文件：`Ubuntu20.04.cmd`

右键编辑，内容如下：

```batch
@echo off
REM 在当前CMD窗口执行
echo Starting Ubuntu-20.04...
wsl -d Ubuntu-20.04 -e bash -c "cd  && exec bash"
pause
```

保存退出。