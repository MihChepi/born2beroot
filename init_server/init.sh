#!/bin/bash
# ssh
apt install -y vim openssh-server openssh-client
systemctl start sshd
cp sshd_config /etc/ssh/sshd_config
systemctl restart sshd

# firewall
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 4242
ufw enable
ufw status numbered
cat /sys/module/apparmor/parameters/enabled


# sudo and groups
apt install -y sudo
usermod -aG sudo khermann
groupadd user42
usermod -aG user42 khermann
id -Gn khermann

# password policy
cp login.defs /etc/login.defs
apt install libpam-cracklib
cp common-password /etc/pam.d/common-password
cp sudoers /etc/sudoers

# script
apt install -y net-tools

# monitoring.sh


# manual
echo "	
	Hi! You need manually change password policy for old users using chage (man chage)
	and change password password for old users using passwd
	and, during evaluation, you must change hostname (hostnamectl set-hostname)
	and add new user and add new user to group user42 (adduser, groupadd)
	and also, you need disable and anable cron task (crontab -l, crontab -e)
     "
	
