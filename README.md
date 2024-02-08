# Batch_script
vol-nonvol 데이터를 추출하여 저장하는 배치 스크립트입니다.

###### [24.02.08] 사용 명령어추가
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
