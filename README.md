# Batch_script
vol-nonvol 데이터를 추출하여 저장하는 배치 스크립트입니다.

[24.02.08] 사용 명령어
-Prefetch
forecopy_handy -p .\_result\_prefetch\

-Vol
<net>
arp -a > "%net%\arp.txt"
netstat -ano > "%net%\netstat.txt"
route print > "%net%\route.txt"

<process>
powershell.exe -command ps > "%process%\ps.txt"
tasklist > "%process%\tasklist"

<logonAccount>
net user > "%logonAccount%\netuser.txt"
net localgroup > "%logonAccount%\netlocalgroup.txt"
