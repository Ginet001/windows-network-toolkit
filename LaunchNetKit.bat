


@echo off
:menu
cls
echo ================================
echo    MY NETWORK TOOLKIT
echo ================================
echo  1. Full Diagnostic (saves log)
echo  2. Quick Ping Test
echo  3. Check Open Ports
echo  4. Flush DNS
echo  5. Release + Renew IP
echo  6. Run PowerShell Health Check
echo  7. nmap Scan
echo  8. ipconfig
echo  9. ipconfig /all
echo  10. Open Logs Folder
echo  0. Exit
echo ================================
set /p choice=Choose an option: 

if "%choice%"=="1" call C:\NetToolkit\scripts\full_diag.bat
if "%choice%"=="2" set /p host=Enter host to ping: & ping %host% & pause
if "%choice%"=="3" netstat -ano | findstr LISTENING & pause
if "%choice%"=="4" ipconfig /flushdns & pause
if "%choice%"=="5" ipconfig /release & ipconfig /renew & pause
if "%choice%"=="6" powershell -ExecutionPolicy Bypass -File C:\NetToolkit\scripts\net_health.ps1 & pause
if "%choice%"=="7" goto nmap_menu
if "%choice%"=="8" ipconfig & pause
if "%choice%"=="9" ipconfig /all & pause
if "%choice%"=="10" explorer C:\NetToolkit\logs
if "%choice%"=="0" exit
goto menu

:nmap_menu
cls
echo ================================
echo       NMAP SCAN OPTIONS
echo ================================
echo  --- Single Target ---
echo  1. Ping Scan (host discovery)
echo  2. Quick Port Scan (top 100 ports)
echo  3. Full Port Scan (all 65535 ports)
echo  4. Service + Version Detection
echo  5. OS Detection (requires admin)
echo  6. Aggressive Scan (OS+version+scripts)
echo  --- Network Scans ---
echo  7. Discover all live hosts on network
echo  8. Scan all hosts + top ports
echo  9. Full network aggressive scan
echo  10. Save network scan to log
echo  0. Back to main menu
echo ================================
set /p nscan=Choose scan type: 

if "%nscan%"=="7" goto net_scan
if "%nscan%"=="8" goto net_ports
if "%nscan%"=="9" goto net_aggressive
if "%nscan%"=="10" goto net_save

if "%nscan%"=="0" goto menu

:: Single target scans
set /p ntarget=Enter target IP or hostname: 
if "%nscan%"=="1" "C:\Program Files (x86)\Nmap\nmap.exe" -sn %ntarget% & pause
if "%nscan%"=="2" "C:\Program Files (x86)\Nmap\nmap.exe" -F %ntarget% & pause
if "%nscan%"=="3" "C:\Program Files (x86)\Nmap\nmap.exe" -p- %ntarget% & pause
if "%nscan%"=="4" "C:\Program Files (x86)\Nmap\nmap.exe" -sV %ntarget% & pause
if "%nscan%"=="5" "C:\Program Files (x86)\Nmap\nmap.exe" -O %ntarget% & pause
if "%nscan%"=="6" "C:\Program Files (x86)\Nmap\nmap.exe" -A %ntarget% & pause
goto nmap_menu

:net_scan
cls
echo Example: 192.168.1.0/24
set /p subnet=Enter your network subnet (e.g. 192.168.1.0/24): 
"C:\Program Files (x86)\Nmap\nmap.exe" -sn %subnet%
pause
goto nmap_menu

:net_ports
cls
set /p subnet=Enter your network subnet (e.g. 192.168.1.0/24): 
"C:\Program Files (x86)\Nmap\nmap.exe" -F %subnet%
pause
goto nmap_menu

:net_aggressive
cls
echo WARNING: This scan is loud and slow on large networks.
set /p subnet=Enter your network subnet (e.g. 192.168.1.0/24): 
"C:\Program Files (x86)\Nmap\nmap.exe" -A %subnet%
pause
goto nmap_menu

:net_save
cls
set /p subnet=Enter your network subnet (e.g. 192.168.1.0/24): 
SET NETLOG=C:\NetToolkit\logs\netscan_%date:~-4,4%%date:~-7,2%%date:~-10,2%.txt
"C:\Program Files (x86)\Nmap\nmap.exe" -sn -F %subnet% -oN %NETLOG%
echo Scan saved to: %NETLOG%
pause
goto nmap_menu