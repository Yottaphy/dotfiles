#!/bin/bash

read -p "User:" USER
read -s -p "Password:" PASSWORD


echo -e "\nSetting up VPN connection" 
echo $PASSWORD | openconnect vpn.jyu.fi -g staff --user=$USER --passwd-on-stdin &

sleep 15

echo -e "\nConnecting to the fileservices server"
smbclient -L //fileservices.ad.jyu.fi -W JYUNET -U $USER --password=$PASSWORD

echo -e "\nMounting U-drive (jyu home)"
mount -t cifs -o domain=JYUNET,username=$USER,password=$PASSWORD,vers=1.0,uid=root,file_mode=0777,dir_mode=0777 //fileservices.ad.jyu.fi/homes/joromero /media/JYUdrives/U-drive

echo -e "\nMounting S-drive (commonshare)"
mount -t cifs -o username=$USER,password=$PASSWORD,vers=1.0,uid=root,file_mode=0777,dir_mode=0777 //fileservices.ad.jyu.fi/commonshare /media/JYUdrives/S-drive
