#### 1.在E:\wsl中创建一个Kali目录
![](assets/将Kali-linux安装到E盘/file-20251211142349865.png)
#### 2.列出所有wsl发行版
```shell
wsl  --list --online
```
![](assets/将Kali-linux安装到E盘/file-20251211140905222.png)
#### 3.下载Kali-linux镜像
```shell
wsl --install -d Kali-linux
```
#### 4.导出为Kali.tar文件到E:\wsl\Kali目录下
```shell
wsl --export  Kali-linux E:\wsl\Kali\Kali.tar
```
![](assets/将Kali-linux安装到E盘/file-20251211142106027.png)
#### 5.取消注册原有的Kali-linux
```shell
wsl --unregister Kali-linux
```
#### 6.导入Kali-linux到E:\WSL\Kali
```shell
wsl --import Kali-linux E:\WSL\Kali E:\WSL\Kali\Kali.tar --version 2
```
![](assets/将Kali-linux安装到E盘/file-20251211142139844.png)
#### 7.启动Kali-linux
```shell
wsl -d Kali-linux
```
![](assets/将Kali-linux安装到E盘/file-20251211142230369.png)
#### 8.MobaXterm连接WSL
![](assets/将Kali-linux安装到E盘/file-20251211143631207.png)
![](assets/将Kali-linux安装到E盘/file-20251211143908218.png)![](assets/将Kali-linux安装到E盘/file-20251211144943004.png)
