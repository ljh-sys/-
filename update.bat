@echo off
:: 防止中文乱码，切换编码页到 UTF-8
chcp 65001 >nul

echo ==============================
echo 正在提交笔记...
echo ==============================

:: 1. 拉取远程最新代码，防止冲突
call git pull origin main

:: 2. 添加所有更改
call git add .

:: 3. 获取当前时间并提交
:: %date% 和 %time% 是系统自带变量
set "timestamp=%date% %time%"
echo 正在使用时间戳 [%timestamp%] 进行提交...
call git commit -m "%timestamp%"

:: 4. 推送到远程
call git push origin main

echo.
echo ==============================
echo 提交成功！
echo 若想查看请访问 https://github.com/ljh-sys/LJH_Node
echo ==============================

:: 暂停窗口，让你看清结果，按任意键关闭
pause