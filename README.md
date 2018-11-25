# Sonicwall Backup Scripts
Scripts to pull backup files from Sonicwall Security Appliances.

Before SonicOS 6.5 came out with it's Cloud Backup and scheduled backup features I was in the process of developing
a web based backup system for Sonicwalls. Once 6.5 came out I abandoned the project, I revisited it earlier this year
and rewrote the scripts to use for a large scale Sonicwall deployment. It performed flawlessly so here it is.

This is two expect scripts. One for the old 5.x SonicOS and one for the 6.x SonicOS.

# Requirements:<br>
-> A Linux machine (Have not tested on Linux Subsystem for Windows but it should work)<br>
-> The 'expect' package <br>
-- Use apt-get install expect for Debian/Ubuntu<br>
-- For CentOS/RHEL add the EPEL repo and run yum install expect [I haven't tried this script yet on my CentOS machine] <br>

# Future Plans:<br>
-> Code the whole thing with VBS scripts for a Windows environment<br>
-> Rewrite both scripts to use something other than FTP<br>


Created by John Amerkhanian

