#!/bin/bash
ABSOLUTE_FILENAME=`readlink -e "$0"`
DIRECTORY=`dirname "$ABSOLUTE_FILENAME"`
IP=`wget -qO- eth0.me`
INSTALL_ROOT="/opt/mtprotoproxy"
gitlink="https://github.com/alexbers/mtprotoproxy.git"

preinstall() {
#downloading
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install htop git

#ports
sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 1443
sudo apt-get install iptables-persistent
sudo service netfilter-persistent save

echo > check_file.cfg
install
}

if [ -e $DIRECTORY/check_file.cfg ]; then 
install; else
preinstall
fi

socks_install() {
read -p "Желаете установить SOCKS5? (y/n)" check
if [[check != "y"]]; then
exit 0
else
./socks_install.sh
}

install() {
if grep "MTProxy" check_file.cfg; then
echo "MTProxy уже установлен на вашем сервере! Установка отменена (для сброса данных о установке введите команду: rm check_file.cfg)"
exit 1
fi

usage() {
    echo "Использование: ./install.sh -s <secret>"
}
SECRET=`head -c 16 /dev/urandom | xxd -ps`

while getopts "s:" arg; do
    case $arg in
        s)
            SECRET=$OPTARG
            ;;
        *)
            usage
            exit 1
    esac
done

if [ -z `echo $SECRET | grep -x '[[:xdigit:]]\{32\}'` ]; then
    echo "Secret должен быть 32-значным ключом, содержащим только HEX-символы"
    exit 1
fi

CONFIG="PORT = 1443
USERS = {\"tg\":  \"${SECRET}\"}"

#MTProxy setup
cd /opt
sudo mkdir $INSTALL_ROOT
sudo chown $USER $INSTALL_ROOT
git clone -b master $gitlink
cd $INSTALL_ROOT
rm config.py
echo | sed  "i$CONFIG" > config.py
sudo cp $DIRECTORY/MTProxy.service /etc/systemd/system/
sudo systemctl daemon-reload && sudo systemctl restart MTProxy.service && sudo systemctl enable MTProxy.service
finish
}

finish() {
cd $DIRECTORY
echo "MTProxy " > check_file.cfg
echo "Установка MTProxy успешно завершена! Ваша ссылка для подключения: https://t.me/proxy?server=${IP}&port=443&secret=${SECRET}"
echo "IP: ${IP}, port: 443 или 1443, secret: ${SECRET}"
if grep "SOCKS5" check_file.cfg; then
exit 0
else
socks_install
fi
}
