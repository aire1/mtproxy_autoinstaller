#!/bin/bash
ABSOLUTE_FILENAME=`readlink -e "$0"`
DIRECTORY=`dirname "$ABSOLUTE_FILENAME"`
IP=`wget -qO- eth0.me`
INSTALL_ROOT="/opt/mtprotoproxy"
gitlink="https://github.com/alexbers/mtprotoproxy.git"
SECRET=$1
AD_TAG=$2

checkinstallation() {
if grep -q "MTProxy" check_file.cfg; then

echo "MTProxy уже установлен на вашем сервере. Установка отменена (для сброса данных о установке введите команду: rm check_file.cfg)"

exit 1
fi
}

finish() {
cd $DIRECTORY

echo "MTProxy " > check_file.cfg

echo "Установка MTProxy успешно завершена! Ваша ссылка для подключения: https://t.me/proxy?server=${IP}&port=443&secret=${SECRET}"

exit 0
}

generate() {
<<<<<<< HEAD

if [ -n "$SECRET" ]; then

SECRET=$SECRET; else

=======
if [ -n "$SECRET" ]
then
SECRET=$SECRET
else
>>>>>>> a6cd4fbb16811a22a1a1aff0368e279ec2985860
SECRET=`head -c 16 /dev/urandom | xxd -ps`

fi

if [ -n "$AD_TAG" ]; then

AD_TAG=$AD_TAG; else

AD_TAG=`head -c 16 /dev/urandom | xxd -ps`

fi

if [ -z `echo $SECRET | grep -x '[[:xdigit:]]\{32\}'` ]; then

    echo "Secret должен быть 32-значным ключом, содержащим только HEX-символы"

exit 1

fi

if [ -z `echo $AD_TAG | grep -x '[[:xdigit:]]\{32\}'` ]; then

    echo "AD_TAG должен быть 32-значным ключом, содержащим только HEX-символы"

exit 1

fi

} 

install() {

generate

CONFIG="PORT = 1443\nUSERS = {\"tg\":  \"${SECRET}\"}"

writing(){

cd $INSTALL_ROOT

rm config.py

echo | sed  "i$CONFIG" > config.py
}

#MTProxy setup
cd /opt

sudo mkdir $INSTALL_ROOT

sudo chown $USER $INSTALL_ROOT

git clone -b master $gitlink

writing

sudo cp $DIRECTORY/MTProxy.service /etc/systemd/system/

sudo systemctl daemon-reload && sudo systemctl restart MTProxy.service && sudo systemctl enable MTProxy.service

finish
}

preinstall() {
#downloading
sudo apt-get update && sudo apt-get upgrade

sudo apt-get install htop git

echo > check_file.cfg

install
}

preinstallports() {
#ports
sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 1443

sudo apt-get install iptables-persistent

sudo service netfilter-persistent save

install
}

checkinstallation

if [ -e $DIRECTORY/check_file.cfg ]; then 

if grep -q "SOCKS" check_file.cfg; then

preinstallports; else

preinstall
fi
fi