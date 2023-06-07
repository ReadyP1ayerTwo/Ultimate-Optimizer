@echo off

echo Welcome to Ultimate Optimizer (FAST CLEANER)!
echo This program will attempt to clear your temporary files,
echo your cache, and your standby memory, which should help improve performance.
pause

rem Stop NVIDIA services
echo Stopping NVIDIA services...
net stop "NvContainerLocalSystem"
echo NVIDIA services stopped.

rem Clear NVIDIA cache
echo Clearing NVIDIA cache...
del /q "C:\ProgramData\NVIDIA Corporation\NV_Cache\*.*"
echo NVIDIA cache cleared.

rem Start NVIDIA services
echo Starting NVIDIA services...
net start "NvContainerLocalSystem"
echo NVIDIA services started.

echo NVIDIA cache cleanup complete.

REM Clean Windows Log Files
echo Cleaning Windows log files...
for /f "tokens=*" %%G in ('wevtutil.exe el') do wevtutil.exe cl "%%G"
echo Windows log files cleared successfully.

REM Clean Windows Delivery Optimization Files
echo Cleaning Windows Delivery Optimization files...
rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution\Download"
echo Windows Delivery Optimization files cleared successfully.

REM Close Spotify if it is running
taskkill /F /IM spotify.exe /T

REM Clear the cache for Spotify
echo Clearing Spotify cache...
rd /s /q "%APPDATA%\Spotify\Storage"
echo Spotify cache cleared.

echo Done.

REM Close Microsoft PowerToys if it is running
taskkill /F /IM PowerToys.exe /T

REM Clear the Updates folder for Microsoft PowerToys
echo Clearing Microsoft PowerToys updates folder...
rd /s /q "%LocalAppData%\Microsoft\PowerToys\Updates"
echo Microsoft PowerToys updates cleared.

REM BROWSER CLEANING

REM Close all instances of Google Chrome
taskkill /F /IM chrome.exe /T

REM Clear the cache for Google Chrome
echo Clearing Google Chrome cache...
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*"
echo Google Chrome cache cleared.

REM Close all instances of Opera GX
taskkill /F /IM opera.exe /T

REM Clear the cache for Opera GX
echo Clearing Opera GX cache...
rd /s /q "%LocalAppData%\Programs\Opera GX\Cache"
echo Opera GX cache cleared.

REM Close all instances of Brave browser
taskkill /F /IM brave.exe /T

REM Clear the cache for Brave browser
echo Clearing Brave cache...
rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache"
md "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache"
echo Brave cache cleared.

REM Additional functionality: Clean temporary files
echo Cleaning temporary files...
del /q /f "%TEMP%\*.*"
echo Temporary files cleared.

echo Clearing standby memory...
echo.
echo Please wait...
echo.

echo === Windows Performance Optimization Script ===
echo.

echo Clearing DNS cache...
ipconfig /flushdns
echo DNS cache cleared.

echo Stopping unnecessary services...
net stop "Print Spooler"
net stop "Connected User Experiences and Telemetry"
echo Unnecessary services stopped.

echo Deleting system error memory dump files...
del /q /s %SystemRoot%\Minidump\*.dmp
echo System error memory dump files deleted.

echo Performing Windows Update cleanup...
DISM.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo Windows Update cleanup completed.

echo Optimizing system registry...
reg optimize
echo System registry optimized.

echo === Optimization completed ===

echo Running PowerShell script as administrator...

powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\Desktop\!Auto-Maintainer""'"

echo PowerShell script executed as administrator.

REM Empty recycle bin
echo Emptying recycle bin...
echo.
echo Please wait...
echo.

REM Windows 10 and later
powershell.exe -Command "Clear-RecycleBin -Force"

REM Windows 7 and earlier
%SystemRoot%\System32\rundll32.exe shell32.dll,Control_RunDLL hotplug.dll

echo Recycle bin emptied.

pause

powershell -Command "Clear-Host; [GC]::Collect(); $unusedMemory = (Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory; $result = [GC]::GetTotalMemory($false); if ($result -gt $unusedMemory) { $result -= $unusedMemory; } $result"

echo It is highly recommended to restart in order to ensure proper cache initialization. Save your work and restart your PC.
echo.

REM Display confirmation dialogue
set /p "choice=RESTART YOUR PC? Type Y for yes, N for no and hit enter: "

REM Check user's choice
if /i "%choice%"=="Y" (
    REM Show restart explanation dialogue box
    powershell -Command "Add-Type -TypeDefinition 'using System; using System.Windows.Forms; class DialogBox { static void Main() { MessageBox.Show(\"Your computer needs to restart in order to ensure proper cache initialization. Save your work and restart your PC\", \"Restart Required\", MessageBoxButtons.OK, MessageBoxIcon.Information); } }'; [DialogBox]::Main()"

    REM Restart the computer
    echo Restarting the computer...
    shutdown /r /t 0
) else (
    echo Computer restart cancelled