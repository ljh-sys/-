@echo off
:: 防止中文乱码，切换编码页到 UTF-8
chcp 65001 >nul
echo ==============================
echo 正在提交笔记...
echo ==============================
call git pull origin main
call git add .
set "timestamp=%date% %time%"
call git commit -m "%timestamp%"
call git push origin main
echo ==============================
echo 提交成功！
echo ==============================
pause