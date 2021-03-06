#!/bin/bash

sudo sed -i '1 {s/^/#/}' /etc/apt/sources.list.d/pve-enterprise.list
sudo sed -i 's/main contrib/main contrib non-free/' /etc/apt/sources.list
sudo apt update
sudo apt upgrade -y
sudo apt install -y intel-microcode tuned unattended-upgrades fail2ban apparmor-profiles apparmor-profiles-extra

sudo tuned-adm profile virt-host

sudo curl https://raw.githubusercontent.com/Whonix/security-misc/master/etc/modprobe.d/30_security-misc.conf -o /etc/modprobe.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Whonix/security-misc/master/etc/sysctl.d/30_security-misc.conf -o /etc/sysctl.d/30_security-misc.conf
sudo curl https://raw.githubusercontent.com/Whonix/security-misc/master/etc/sysctl.d/30_silent-kernel-printk.conf -o /etc/sysctl.d/30_silent-kernel-printk.conf

sudo rm -rf /etc/chrony/chrony.conf
sudo curl https://raw.githubusercontent.com/GrapheneOS/infrastructure/main/chrony.conf -o /etc/chrony/chrony.conf

echo "* hard core 0" | sudo tee -a /etc/security/limits.conf

sudo bash <(curl -s https://raw.githubusercontent.com/Weilbyte/PVEDiscordDark/master/PVEDiscordDark.sh ) install
sudo sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js 
sudo systemctl restart pveproxy.service
