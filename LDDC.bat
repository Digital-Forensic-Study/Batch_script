:: 24.02.06 ~
:: [Live Disk Data Collector] 휘발성과 비휘발성 데이터 수집
@echo off

::dir 생성 경로 설정
set "result=_result"
set "vol=%result%\_vol"
set "nonvol=%result%\_nonvol"

set "prefetch=%result%\_prefetch"

::vol 데이터 생성 경로
set "net=%vol%\_net"
set "process=%vol%\_process"
set "logonAccount=%vol%\_logonAccount"

::nonVol 데이터 생성 경로
set "cache=%nonvol%\_cache"
set "cookie=%nonvol%\_cookie"
set "registry=%nonvol%\_registry"
set "mft=%nonvol%\_mft"
set "eventLog=%nonvol%\_eventlog"
::set "vbr=%nonvol%\_vbr"
set "recent=%nonvol%\_recent"
set "quickLaunch=%nonvol%\_quicklaunch"

:REDO
echo ----------------------------------------------
echo.
echo.
echo.
echo   :          :'''.      :'''.        .'''''.
echo   :          :    '.    :    '.    .'
echo   :          :     :    :     :    :
echo   :          :    .'    :    .'    '.
echo   :.......   :...'      :...'        '.....'
echo.
echo.
echo.
echo --------- (Live Disk Data Collector) ---------
echo 1. All data
echo 2. Volatile data
echo 3. Non-volatile data
echo 4. Program end
echo ----------------------------------------------
set /p inputNum=Enter the number you want to run :

if "%inputNum%"=="1" goto 1
if "%inputNum%"=="2" goto 2
if "%inputNum%"=="3" goto 3
if "%inputNum%"=="4" goto 4
goto ERROR

::all
:1
if not exist "%result%" (
    mkdir "%result%"
    echo Created %result% directory. 
    echo START Date: %DATE% Time: %TIME% > _result\log.txt
) else (
    echo %result% directory already exists. passing...
)

if not exist "%prefetch%" (
    mkdir "%prefetch%"
    echo Created %prefetch% directory. 
    echo start prefetch_part at Date: %DATE% Time: %TIME% >> _result\log.txt
    forecopy_handy.exe -p .\_result\_prefetch\
    ::프리패치 파일 리스트들을 뽑아주는 명령어지만 forecopy_handy에서 프리패치 파일 자체들을 뽑아주는 명령어 찾아서 폐기
    ::dir %SystemRoot%\Prefetch > result\_prefetch\prefetch_log.txt
) else (
    echo %prefetch% directory already exists. passing...
)

if not exist "%vol%" (
    mkdir "%vol%"
    echo Created %vol% directory.

    ::net
    if not exist "%net%" (
        mkdir "%net%"
        set "net=%vol%\_net"
        echo start net_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        ipconfig > "%net%\ipconfig.txt"
        getmac > "%net%\getmac.txt"
        net > "%net%\net.txt"
        netstat -ano > "%net%\netstat.txt"
        tcpvcon > "%net%\tcpvcon.txt"
        arp -a > "%net%\arp.txt"
        route print > "%net%\route.txt"
    ) else (
        echo %net% directory already exists. passing...
    )

    ::process
    if not exist "%process%" (
        mkdir "%process%"
        set "process=%vol%\_process"
        echo start process_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        powershell.exe -command ps > "%process%\ps.txt"
        tasklist > "%process%\tasklist"
        handle.exe > "%process%\handle_opened_files.txt"
        Listdlls.exe > "%process%\Listdlls.txt"
    ) else (
        echo %process% directory already exists. passing...
    )

    ::logonAccount
    if not exist "%logonAccount%" (
        mkdir "%logonAccount%"
        set "logonAccount=%vol%\_logonAccount"
        echo start logonAccount_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        net session > "%logonAccount%\netsession.txt"
        net user > "%logonAccount%\netuser.txt"
        net localgroup > "%logonAccount%\netlocalgroup.txt"
        net localgroup administrators  > "%logonAccount%\netlocalgroupadministrators.txt"
        logonsessions.exe > "%logonAccount%\logonsessions.txt"
        PsLoggedon.exe > "%logonAccount%\PsLoggedon.txt"
    ) else (
        echo %logonAccount% directory already exists. passing...
    )

) else (
    echo %vol% directory already exists. passing...
)

if not exist "%nonvol%" (
    mkdir "%nonvol%"
    echo Created %nonvol% directory.

    ::cache
    if not exist "%cache%" (
        mkdir "%cache%"
        set "cache=%nonvol%\_cache"
        :: set "chromeCache=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache"
        echo start cache_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"
    ) else (
        echo %cache% directory already exists. passing...
    )

    ::cookie
    if not exist "%cookie%" (
        mkdir "%cookie%"
        set "cookie=%nonvol%\_cookie"
        echo start cookie_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Network" "%cookie%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cookie%\cookie.txt"
    ) else (
        echo %cookie% directory already exists. passing...
    )

    ::registry
    if not exist "%registry%" (
        mkdir "%registry%"
        echo start registry_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        forecopy_handy.exe -g .\_result\_nonvol\_registry\
    ) else (
        echo %registry% directory already exists. passing...
    )
    
    ::mft
    if not exist "%mft%" (
        mkdir "%mft%"
        echo start mft_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        forecopy_handy.exe -m .\_result\_nonvol\_mft\
    ) else (
        echo %mft% directory already exists. passing...
    )

    ::eventlog
    if not exist "%eventLog%" (
        mkdir "%eventLog%"
        echo start eventlog_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        forecopy_handy.exe -e .\_result\_nonvol\_eventlog\
    ) else (
        echo %eventLog% directory already exists. passing...
    )

    ::recent
    if not exist "%recent%" (
        mkdir "%recent%"
        set "recent=%nonvol%\_recent"
        echo start recent_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "%APPDATA%\Microsoft\Office\Recent" "%recent%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%recent%\recent.txt"
    ) else (
        echo %recent% directory already exists. passing...
    )

    ::quicklaunch
    if not exist "%quickLaunch%" (
        mkdir "%quickLaunch%"
        set "quickLaunch=%nonvol%\_quicklaunch"
        echo start quicklaunch_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "%APPDATA%\Microsoft\Internet Explorer\Quick Launch" "%quickLaunch%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%quickLaunch%\quicklaunch.txt"
    ) else (
        echo %quickLaunch% directory already exists. passing...
    )

) else (
    echo %nonvol% directory already exists. passing...
)

goto REDO
pause

::vol
:2 
if not exist "%result%" (
    mkdir "%result%"
    echo Created %result% directory. 
    echo START Date: %DATE% Time: %TIME% > _result\log.txt
) else (
    echo %result% directory already exists. passing...
)

if not exist "%vol%" (
    mkdir "%vol%"
    echo Created %vol% directory.
    ::net
    if not exist "%net%" (
        mkdir "%net%"
        set "net=%vol%\_net"
        echo start net_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        ipconfig > "%net%\ipconfig.txt"
        getmac > "%net%\getmac.txt"
        net > "%net%\net.txt"
        netstat -ano > "%net%\netstat.txt"
        tcpvcon > "%net%\tcpvcon.txt"
        arp -a > "%net%\arp.txt"
        route print > "%net%\route.txt"
    ) else (
        echo %net% directory already exists. passing...
    )

    ::process
    if not exist "%process%" (
        mkdir "%process%"
        set "process=%vol%\_process"
        echo start process_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        powershell.exe -command ps > "%process%\ps.txt"
        tasklist > "%process%\tasklist"
        handle.exe > "%process%\handle_opened_files.txt"
        Listdlls.exe > "%process%\Listdlls.txt"
    ) else (
        echo %process% directory already exists. passing...
    )

    ::logonAccount
    if not exist "%logonAccount%" (
        mkdir "%logonAccount%"
        set "logonAccount=%vol%\_logonAccount"
        echo start logonAccount_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        net session > "%logonAccount%\netsession.txt"
        net user > "%logonAccount%\netuser.txt"
        net localgroup > "%logonAccount%\netlocalgroup.txt"
        net localgroup administrators  > "%logonAccount%\netlocalgroupadministrators.txt"
        logonsessions.exe > "%logonAccount%\logonsessions.txt"
        PsLoggedon.exe > "%logonAccount%\PsLoggedon.txt"
    ) else (
        echo %logonAccount% directory already exists. passing...
    )

) else (
    echo %vol% directory already exists. passing...
)

goto REDO
pause

::nonvol
:3
if not exist "%result%" (
    mkdir "%result%"
    echo Created %result% directory. 
    echo START Date: %DATE% Time: %TIME% > _result\log.txt
) else (
    echo %result% directory already exists. passing...
)

if not exist "%prefetch%" (
    mkdir "%prefetch%"
    echo Created %prefetch% directory. 
    echo start prefetch_part at Date: %DATE% Time: %TIME% >> _result\log.txt
    forecopy_handy.exe -p .\_result\_prefetch\
    ::프리패치 파일 리스트들을 뽑아주는 명령어지만 forecopy_handy에서 프리패치 파일 자체들을 뽑아주는 명령어 찾아서 폐기
    ::dir %SystemRoot%\Prefetch > result\_prefetch\prefetch_log.txt
) else (
    echo %prefetch% directory already exists. passing...
)

if not exist "%nonvol%" (
    mkdir "%nonvol%"
    echo Created %nonvol% directory.

    ::cache
    if not exist "%cache%" (
        mkdir "%cache%"
        set "cache=%nonvol%\_cache"
        :: set "chromeCache=C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache"
        echo start cache_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"
    ) else (
        echo %cache% directory already exists. passing...
    )

    ::cookie
    if not exist "%cookie%" (
        mkdir "%cookie%"
        set "cookie=%nonvol%\_cookie"
        echo start cookie_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Network" "%cookie%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cookie%\cookie.txt"
    ) else (
        echo %cookie% directory already exists. passing...
    )

    ::registry
    if not exist "%registry%" (
        mkdir "%registry%"
        echo start registry_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        forecopy_handy.exe -g .\_result\_nonvol\_registry\
    ) else (
        echo %registry% directory already exists. passing...
    )
    
    ::mft
    if not exist "%mft%" (
        mkdir "%mft%"
        echo start mft_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        forecopy_handy.exe -m .\_result\_nonvol\_mft\
    ) else (
        echo %mft% directory already exists. passing...
    )

    ::eventlog
    if not exist "%eventLog%" (
        mkdir "%eventLog%"
        echo start eventlog_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        forecopy_handy.exe -e .\_result\_nonvol\_eventlog\
    ) else (
        echo %eventLog% directory already exists. passing...
    )
    
    ::recent
    if not exist "%recent%" (
        mkdir "%recent%"
        set "recent=%nonvol%\_recent"
        echo start recent_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "%APPDATA%\Microsoft\Office\Recent" "%recent%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%recent%\recent.txt"
    ) else (
        echo %recent% directory already exists. passing...
    )

    ::quicklaunch
    if not exist "%quickLaunch%" (
        mkdir "%quickLaunch%"
        set "quickLaunch=%nonvol%\_quicklaunch"
        echo start quicklaunch_part at Date: %DATE% Time: %TIME% >> _result\log.txt
        robocopy "%APPDATA%\Microsoft\Internet Explorer\Quick Launch" "%quickLaunch%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%quickLaunch%\quicklaunch.txt"
    ) else (
        echo %quickLaunch% directory already exists. passing...
    )
  
) else (
    echo %nonvol% directory already exists. passing...
)

goto REDO
pause

::end
:4
echo Exit the program.
echo END Date: %DATE% Time: %TIME% >> _result\log.txt
exit
pause

::ERROR
:ERROR
echo Invalid input. Check the values you entered.
goto REDO
pause
