#! pwsh

# 重启 SmoothScroll 以回避 烦人的 付费 提醒.
# 请手动修改 下文 提及 的 SmoothScroll 安装路径.

Stop-Process -Name SmoothScroll -Force
start "C:/Users/Les1i/AppData/Local/SmoothScroll/app-1.2.4.0/SmoothScroll.exe"

# Local Variables:
# coding: utf-8-unix
# End:
