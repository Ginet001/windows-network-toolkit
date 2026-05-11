@echo off
SET LOG=C:\NetToolkit\logs\diag_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.txt
SET LOG=%LOG: =0%

echo ===== NETWORK DIAGNOSTIC REPORT ===== > %LOG%
echo Run time: %date% %time% >> %LOG%
echo. >> %LOG%

echo [IP CONFIG] >> %LOG%
ipconfig /all >> %LOG%

echo. >> %LOG%
echo [DNS CACHE] >> %LOG%
ipconfig /displaydns >> %LOG%

echo. >> %LOG%
echo [ROUTING TABLE] >> %LOG%
route print >> %LOG%

echo. >> %LOG%
echo [ARP TABLE] >> %LOG%
arp -a >> %LOG%

echo. >> %LOG%
echo [ACTIVE CONNECTIONS] >> %LOG%
netstat -ano >> %LOG%

echo. >> %LOG%
echo [PING GATEWAY] >> %LOG%
for /f "tokens=3" %%i in ('route print ^| findstr "0.0.0.0"') do (
    ping -n 4 %%i >> %LOG%
    goto :doneGW
)
:doneGW

echo. >> %LOG%
echo [PING GOOGLE DNS] >> %LOG%
ping -n 4 8.8.8.8 >> %LOG%

echo. >> %LOG%
echo [DNS RESOLUTION TEST] >> %LOG%
nslookup google.com >> %LOG%

echo. >> %LOG%
echo [TRACEROUTE TO 8.8.8.8] >> %LOG%
tracert -d -h 15 8.8.8.8 >> %LOG%

echo Done! Report saved to: %LOG%
start notepad %LOG%