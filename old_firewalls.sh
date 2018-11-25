#!/usr/bin/expect -f

# Tested on SonicOS 5.8 and 5.9

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
expect {
        "*Are you sure*" {
                send "yes\r"
                exp_continue
        }
        "Password:" {
                send "$password\r"
        }
}
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
expect "*#" {send "export current-config sonicos ftp 'ftp://$ftpuser:$ftpass@$ftpip/$dir/settings_$date.exp'\r"}
expect "*#" {send "\r"}
expect "*#" {send "export firmware current ftp 'ftp://$ftpuser:$ftpass@$ftpip/$dir/firmware_$date.sig'\r"}
expect "*#" {send "exit\r"}
expect "*>" {send "exit\r"}




# Due to the lack of the tech-support-report command in SonicOS 5.x we have to 
# print the report on screen then save the screen to file and curl it to the FTP server
# I have this section commented out for now until I iron it out

# Diag section
#log_file -noappend ~/diag_$date.wri
#spawn ssh $username@$ip
#expect "Password:" {send "$password\r"}
#expect "$username@*" {send "configure\r"}
#expect {
#        "Do you wish to preempt them (yes/no)?" {
#                send "yes\r"
#                exp_continue
#        }
#        "*#" {
#                send "\r"
#        }
#}
#expect "*#" {send "show tech-support-report\r"}
#expect "*End of TSR*" {send "exit\r"}
#expect "*>" {send "curl -T ~/diag_$date.wri 'ftp://$ftpip/$dir/' -u sonicwall:jsajsa"}



