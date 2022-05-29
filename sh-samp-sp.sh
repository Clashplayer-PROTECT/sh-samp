#!/bin/bash
# Script Auto Install SAMP
#=====================================================================================
# Author:   Clashplayer#3630  - ecko#7104
#=====================================================================================
#=====================================================================================
# Root Force
# By Clashplayer#8772 and ecko#7104
#Supported systems:
supported="Ubuntu"
COLOR1='\033[0;32m'                                         #green color
COLOR2='\033[0;31m'                                         #red color
COLOR3='\33[0;33m'
NC='\033[0m'                                                #no color

 if [ "$(id -u)" != "0" ]; then
         printf "${RED}ERROR : SH-SAMP no tiene acceso root. (usar chmod 777 sampauto.sh)⛔️\\n" 1>&2
         printf "\\n"
         exit 1
 fi
    printf "${COLOR1}©️  Copyright | All rights reserved.©️ \\n"
    printf "${COLOR2}💻 sistema requerido : Ubuntu 18.04 and 20.04 💻\\n"
    printf "${NC}\\n"    
    sleep 6
#############################################################################

# Actualizar el sistema
apt update -y
apt upgrade -y
apt install sudo xz-utils git curl screen -y

#Installation de 5104
echo
    printf "${YELLOW} ¿Quieres instalar el servidor SAMP? ❓  [o/N]\\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
printf "${CYAN} Iniciando la instalación del servidor SA:MP  !"
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
    printf "${YELLOW} ¿Quiere crear una instalación automática de MariaDB   ❓ [o/N]\\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
printf "${CYAN} Iniciando la instalación de MariaDB para el servidor SA:MP !"
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

echo -n -e "${GREEN}¿Cuál será el nombre de su base de datos? ❓ ${YELLOW}(sh_base)${reset}: "
read -r DBNAME

if [[ "$DBNAME" == "" ]]; then
  DBNAME="sh_base"  
fi

sleep 2
echo -n -e "${GREEN}Cual será el usuario de su base de datos ❓ ${YELLOW}(sh-fivem)${reset}: "
read -r DBUSER

if [[ "$DBUSER" == "" ]]; then
  DBUSER="sh-fivem"  
fi

sleep 2
echo -n -e "${GREEN}¿Cuál será la contraseña de su base de datos ❓ ${reset}: "
read -s -r DBPASS

while true; do

  if [[ "$DBPASS" == "" ]]; then
    echo -e "${red}La contraseña debe ser obligatoria !"
    echo -n -e "${GREEN}¿Cuál es la contraseña de su base de datos? ❓ ${reset}: "
    read -s -r DBPASS
  else
    echo -e "${GREEN}La contraseña es correcta !${reset}" 
    break 
  fi
done 


#Installation PHPMYADMIN
echo
    printf "${YELLOW} Quiere crear una instalación automática de PHPMYADMIN   ❓ [o/N]\\n"
    read reponse
if [[ "$reponse" == "o" ]]
then 
printf "${CYAN} ¡Iniciando la instalación de phpMyAdmin para SA:MP!"  !
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
    printf "${COLOR3} La instalación se ha completado!"
  
