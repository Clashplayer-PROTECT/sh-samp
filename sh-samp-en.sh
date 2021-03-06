#!/bin/bash
# Script Auto Install SAMP
#=====================================================================================
# Author:   Clashplayer#3630 
#=====================================================================================
#=====================================================================================
# Root Force
# By Clashplayer#8772

cat << "EOF"
  /$$$$$$  /$$   /$$         /$$$$$$$$ /$$$$$$ /$$    /$$ /$$$$$$$$ /$$      /$$       /$$    /$$  /$$$$$$        /$$  
 /$$__  $$| $$  | $$        | $$_____/|_  $$_/| $$   | $$| $$_____/| $$$    /$$$      | $$   | $$ /$$__  $$     /$$$$  
| $$  \__/| $$  | $$        | $$        | $$  | $$   | $$| $$      | $$$$  /$$$$      | $$   | $$|__/  \ $$    |_  $$  
|  $$$$$$ | $$$$$$$$ /$$$$$$| $$$$$     | $$  |  $$ / $$/| $$$$$   | $$ $$/$$ $$      |  $$ / $$/  /$$$$$$/      | $$  
 \____  $$| $$__  $$|______/| $$__/     | $$   \  $$ $$/ | $$__/   | $$  $$$| $$       \  $$ $$/  /$$____/       | $$  
 /$$  \ $$| $$  | $$        | $$        | $$    \  $$$/  | $$      | $$\  $ | $$        \  $$$/  | $$            | $$  
|  $$$$$$/| $$  | $$        | $$       /$$$$$$   \  $/   | $$$$$$$$| $$ \/  | $$         \  $/   | $$$$$$$$ /$$ /$$$$$$
 \______/ |__/  |__/        |__/      |______/    \_/    |________/|__/     |__/          \_/    |________/|__/|______/                             
EOF
#Supported systems:
supported="Ubuntu"
COLOR1='\033[0;32m'                                         #green color
COLOR2='\033[0;31m'                                         #red color
COLOR3='\33[0;33m'
NC='\033[0m'                                                #no color

 if [ "$(id -u)" != "0" ]; then
         printf "${RED}ERREUR : SH-FIVEM  does not have root access. ⛔️\\n" 1>&2
         printf "\\n"
         exit 1
 fi
    printf "${COLOR1}©️  Copyright | All rights reserved.©️ \\n"
    printf "${COLOR2}💻 Supported systems : Ubuntu 18.04 and 20.04 💻\\n"
    printf "${NC}\\n"    
    sleep 6
#############################################################################

# Prérequis installation Five M
apt update -y
apt upgrade -y
apt install sudo xz-utils git curl screen -y

#Installation de 5104
echo
    printf "${YELLOW} Do you want to install the SAMP server? ❓  [o/N]\\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
printf "${CYAN} Start the installation of the SA:MP server  !"
apt install libstdc++6 wget nano
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
cd /home/
mkdir -p samp
cd /home/samp
wget http://files.sa-mp.com/samp037svr_R2-1.tar.gz
tar -zxf samp037svr_R2-1.tar.gz 

fi
sleep 2

# Installation MARIADB
echo
    printf "${YELLOW} Would you like to create an automatic installation of MariaDB   ❓ [o/N]\\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
printf "${CYAN} Start the installation of MariaDB for FiveM server !"
    apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg
    LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
    add-apt-repository -y ppa:chris-lea/redis-server
    curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
    apt update -y
    sudo add-apt-repository ppa:ondrej/php
    sudo apt-get update -y
    sudo apt-get install php-mbstring php-gettext
    sudo apt -y install php7.4
    apt install -y php7.4-{cli,gd,mysql,pdo,mbstring,tokenizer,bcmath,xml,fpm,curl,zip} mariadb-client mariadb-server apache2 tar unzip git 
    php -v

fi
sleep 2

echo -n -e "${GREEN}What is the name of your database ❓ ${YELLOW}(sh_base)${reset}: "
read -r DBNAME

if [[ "$DBNAME" == "" ]]; then
  DBNAME="sh_base"  
fi

sleep 2
echo -n -e "${GREEN}Who is the user of your database ❓ ${YELLOW}(sh-fivem)${reset}: "
read -r DBUSER

if [[ "$DBUSER" == "" ]]; then
  DBUSER="sh-fivem"  
fi

sleep 2
echo -n -e "${GREEN}What is the password of your database ❓ ${reset}: "
read -s -r DBPASS

while true; do

  if [[ "$DBPASS" == "" ]]; then
    echo -e "${red}The password must be mandatory !"
    echo -n -e "${GREEN}What is the password of your database ❓ ${reset}: "
    read -s -r DBPASS
  else
    echo -e "${GREEN}The password is correct !${reset}" 
    break 
  fi
done 


#Installation PHPMYADMIN
echo
    printf "${YELLOW} Remember to create an automatic installation of PHPMYADhMIN   ❓ [o/N]\\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
printf "${CYAN} Starting the installation of phpMyAdmin for Five M!"  !"
    apt install phpmyadmin
    sudo service apache2 restart
    ln -s /usr/share/phpmyadmin/ /var/www/html/phpmyadmin
fi
echo -e "Configuration of the user"
  echo "Set MySQL root password"
  sleep 2
  mysql -e "CREATE USER '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';"
  mysql -e "CREATE DATABASE ${DBNAME};"
  mysql -p -e "GRANT ALL PRIVILEGES ON * . * TO '${DBUSER}'@'localhost';"
  mysql -e "FLUSH PRIVILEGES;"
  
  sleep 3
    printf "${COLOR3} The installation is complete !"
    printf "${COLOR3} Discord of SH-SAMP : https://discord.gg/EMcWM5T3gM \\n"
    printf "${COLOR3} Github of Clahsplayer on SH-SAMP: https://github.com/Clashplayer-PROTECT/sh-samp \\n"
    echo -en '\n'
    sleep 3
    printf "${COLOR1} TOPO on MySQL \\n"
    printf "${COLOR1} Link to phpMyAdmin : http://$(hostname -I)/phpmyadmin/ \\n"
    printf "${COLOR1} MySQL database user name: ${DBUSER}"
    printf "${COLOR1} MySQL database connection password: ${DBPASS} \\n"
    echo -en '\n'
    sleep 3
    printf "${COLOR2}💻 TOPO on creation of your server ! \\n"
    printf "${COLOR2}💻 Folder path   : /home/samp \\n"
    printf "${NC}\\n"    
cat << "EOF"
  /$$$$$$  /$$   /$$         /$$$$$$$$ /$$$$$$ /$$    /$$ /$$$$$$$$ /$$      /$$       /$$    /$$  /$$$$$$        /$$  
 /$$__  $$| $$  | $$        | $$_____/|_  $$_/| $$   | $$| $$_____/| $$$    /$$$      | $$   | $$ /$$__  $$     /$$$$  
| $$  \__/| $$  | $$        | $$        | $$  | $$   | $$| $$      | $$$$  /$$$$      | $$   | $$|__/  \ $$    |_  $$  
|  $$$$$$ | $$$$$$$$ /$$$$$$| $$$$$     | $$  |  $$ / $$/| $$$$$   | $$ $$/$$ $$      |  $$ / $$/  /$$$$$$/      | $$  
 \____  $$| $$__  $$|______/| $$__/     | $$   \  $$ $$/ | $$__/   | $$  $$$| $$       \  $$ $$/  /$$____/       | $$  
 /$$  \ $$| $$  | $$        | $$        | $$    \  $$$/  | $$      | $$\  $ | $$        \  $$$/  | $$            | $$  
|  $$$$$$/| $$  | $$        | $$       /$$$$$$   \  $/   | $$$$$$$$| $$ \/  | $$         \  $/   | $$$$$$$$ /$$ /$$$$$$
 \______/ |__/  |__/        |__/      |______/    \_/    |________/|__/     |__/          \_/    |________/|__/|______/  
EOF
