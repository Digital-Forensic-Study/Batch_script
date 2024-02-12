# LDDC (Live Disk Data Collector) Batch_script
Live Disk Data (vol-nonvol 데이터)를 추출하여 저장하는 배치 스크립트입니다.

###### [24.02.08] prefetch,vol_net, vol_process, vol_logonAccount 명령어추가
###### [24.02.09] vol_logonAccount 명령어추가
###### [24.02.12] nonvol_cache 명령어추가
## Prefetch
<ul>forecopy_handy -p .\_result\_prefetch\</ul>

## Vol
#### net
<ul>arp -a > "%net%\arp.txt"</ul>
<ul>netstat -ano > "%net%\netstat.txt"</ul>
<ul>route print > "%net%\route.txt"</ul>

#### process
<ul>powershell.exe -command ps > "%process%\ps.txt"</ul>
<ul>tasklist > "%process%\tasklist"</ul>

#### logonAccount
<ul>net user > "%logonAccount%\netuser.txt"</ul>
<ul>net localgroup > "%logonAccount%\netlocalgroup.txt"</ul>
<ul>net localgroup administrators  > "%logonAccount%\netlocalgroupadministrators.txt"</ul>

## Nonvol
<ul>robocopy "%chromeCache%" "%cache%" /s /e /z /copy:DAT /r:3 /w:5 /log:"%cache%\robocopy_chrome_cache.txt"</ul>
