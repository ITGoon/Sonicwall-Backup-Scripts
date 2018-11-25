#!/usr/bin/expect -f

# Tested and working on SonicOS 6.2 and 6.5

# Usually the username is admin
set username USERNAME
set password PASSWORD

# The IP address of the Sonicwall (WAN or LAN depending where this script will run from)
set ip IP_ADDRESS

# Directory on your FTP server where the backups should go
set dir DIRECTORY_NAME

# Set your backup destination FTP server ip and login info
set ftpip FTP_SERVER_IP
set ftpuser FTP_USER
set ftpass FTP_PASSWORD

# Below is for clock setting
set timeout 580
set now [clock seconds]
set date [clock format $now -format {%b-%d-%Y}]

# Be sure SSH management is enabled on the interface this script will login on
spawn ssh $username@$ip
expect "*password:" {send "$password\r"}
expect "$username@*" {send "configure\r"}
expect {
        "Do you wish to preempt them (yes/no)?" {
                send "yes\r"
                exp_continue
        }
        "*#" {
                send "firmware backup\r"
        }
}
expect "*#" {send "firmware backup\r"}
expect "*#" {send "export current-config exp ftp ftp://$ftpuser:$ftpass@$ftpip/$dir/settings_$date.exp\r"}
expect "*#" {send "\r"}
expect "*#" {send "export firmware current ftp ftp://$ftpuser:$ftpass@$ftpip/$dir/firmware_$date.sig\r"}
expect "*#" {send "export tech-support-report ftp ftp://$ftpuser:$ftpass@$ftpip/$dir/diag_$date.wri\r"}
expect "*#" {send "exit\r"}
expect "*@" {send "exit\r"}
