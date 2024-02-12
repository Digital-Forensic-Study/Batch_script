# LDDC (Live Disk Data Collector) Batch_script
Live Disk Data (vol-nonvol 데이터)를 추출하여 저장하는 배치 스크립트입니다.

###### [24.02.08] prefetch,vol_net, vol_process, vol_logonAccount 명령어추가
###### [24.02.09] vol_logonAccount 명령어추가
###### <s>[24.02.12] nonvol_cache 명령어추가 chrome 웹에서 캐시 데이터 저장위치 에서 하위 디렉토리들과 캐시 데이터를 포함하여 텍스쳐로 저장하는 robocopy 명령어 추가 과정에서 오류 발생하여 제거</s>
###### [24.02.12] vol_net 명령어추가
###### [24.02.12] nonvol_cache 명령어추가
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

#### logonAccount
<ul>net user > "%logonAccount%\netuser.txt"</ul>
<ul>net localgroup > "%logonAccount%\netlocalgroup.txt"</ul>
<ul>net localgroup administrators  > "%logonAccount%\netlocalgroupadministrators.txt"</ul>

## Nonvol
<s><ul>robocopy "%chromeCache%" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"</ul></s>
<ul>robocopy "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"</ul>
