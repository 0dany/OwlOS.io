@echo off
::Running script as administrator
>nul 2>&1 reg.exe query "HKU\S-1-5-19" || (
    echo set UAC = CreateObject^("Shell.Application"^) > "%temp%\Getadmin.vbs"
    echo UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%temp%\Getadmin.vbs"
    "%temp%\Getadmin.vbs"
    DEL /f /q "%temp%\Getadmin.vbs" >nul 2>&1
    exit /b
)

echo Configuring HDD Settings...
echo.

fsutil behavior set disabledeletenotify 1
schtasks /Change /Enable /TN "\Microsoft\Windows\Defrag\ScheduledDefrag"
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "2" /f

echo.
echo Reboot Computer for Apply Changes.

pause