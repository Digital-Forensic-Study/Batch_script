# LDDC (Live Disk Data Collector) Batch_script
Live Disk Data 활성 시스템에서 휘발성/비휘발성 데이터를 추출하여 저장하는 배치 스크립트입니다.

###### [24.02.08] prefetch,vol_net, vol_process, vol_logonAccount 명령어추가
###### [24.02.09] vol_logonAccount 명령어추가
###### <s>[24.02.12] nonvol_cache 명령어추가 chrome 웹에서 캐시 데이터 저장위치 에서 하위 디렉토리들과 캐시 데이터를 포함하여 텍스쳐로 저장하는 robocopy 명령어 추가 과정에서 오류 발생하여 제거</s>
###### [24.02.12] vol_net 명령어추가
###### [24.02.12] nonvol_cache 명령어추가
###### [24.02.12] vol_process 명령어추가
###### [24.02.12] vol_logonAccount 명령어추가
###### [24.02.13] nonvol_registry 명령어추가
###### [24.02.13] nonvol_mft 명령어추가
###### [24.02.13] nonvol_eventlog 명령어추가
###### <s>[24.02.13] nonvol_vbr 명령어추가 비휘발성 데이터를 선별적으로 수집하는데 있어서 추가적인 데이터 분석이 필요하기에 의도와는 맞지 않다고 판단 후 제거</s>
###### [24.02.13] nonvol_recent 명령어추가
###### [24.02.13] nonvol_quicklaunch 명령어추가
###### [24.02.13] nonvol_cookie 명령어추가

<br>

## Set-up
#### ▶ LDDC는 forecopy, sysinternals suite 다운로드 및 환경변수 설정이 선행적으로 필요합니다. ◀

<br>
<br>

- **Download Links**

[sysinternals suite]
>https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite

<br>

[forecopy]
>https://code.google.com/archive/p/proneer/downloads

<br>
<br>

- **환경변수 설정**
> 설정 -> 시스템 -> 정보 -> 고급 시스템 설정 -> 고급 -> 환경 변수 -> 시스템 변수 (Path) 편집 -> 새로 만들기 -> sysinternals suite와 forecopy가 위치한 폴더의 경로를 각각 입력 후 저장

<br>

## ※ 주의사항
- 관리자 권한으로 실행하지 않을 시 몇몇의 명령어가 재대로 동작하지 않을 수 있습니다.

- 관리자 권한으로 실행하고 나면 `_result` 파일은 **C:\Windows\System32**에 저장됩니다.

<br>

## Prefetch
<ul>forecopy_handy -p .\_result\_prefetch\</ul>

## Vol
#### net
<ul>ipconfig > "%net%\ipconfig.txt"</ul>
<ul>getmac > "%net%\getmac.txt"</ul>
<ul>net > "%net%\net.txt"</ul>
<ul>netstat -ano > "%net%\netstat.txt"</ul>
<ul>tcpvcon > "%net%\tcpvcon.txt"</ul>
<ul>arp -a > "%net%\arp.txt"</ul>
<ul>route print > "%net%\route.txt"</ul>

#### process
<ul>powershell.exe -command ps > "%process%\ps.txt"</ul>
<ul>tasklist > "%process%\tasklist"</ul>
<ul>handle.exe > "%process%\handle_opened_files.txt"</ul>
<ul>Listdlls.exe > "%process%\Listdlls.txt"</ul>

#### logonAccount
<ul>net session > "%logonAccount%\netsession.txt"</ul>
<ul>net user > "%logonAccount%\netuser.txt"</ul>
<ul>net localgroup > "%logonAccount%\netlocalgroup.txt"</ul>
<ul>net localgroup administrators  > "%logonAccount%\netlocalgroupadministrators.txt"</ul>
<ul>logonsessions.exe > "%logonAccount%\logonsessions.txt"</ul>
<ul>PsLoggedon.exe > "%logonAccount%\PsLoggedon.txt"</ul>

## Nonvol
#### cache
<s><ul>robocopy "%chromeCache%" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"</ul></s>
<ul>robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"</ul>

#### cookie
<ul>robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Network" "%cookie%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cookie%\cokie.txt"</ul>

#### registry
<ul>forecopy_handy.exe -g .\_result\_nonvol\_registry\</ul>

#### mft
<ul>forecopy_handy.exe -m .\_result\_nonvol\_mft\</ul>

#### eventlog
<ul>forecopy_handy.exe -e .\_result\_nonvol\_eventlog\</ul>

#### <s>vbr</s>
<ul><s>robocopy "%SystemDrive%\Boot" "%vbr%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%vbr%\vbr.txt"</s></ul>

#### recent
<ul>robocopy "%APPDATA%\Microsoft\Office\Recent" "%recent%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%recent%\recent.txt"</ul>

#### quicklaunch
<ul>robocopy "%APPDATA%\Microsoft\Internet Explorer\Quick Launch" "%quickLaunch%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%quickLaunch%\quicklaunch.txt"</ul>
