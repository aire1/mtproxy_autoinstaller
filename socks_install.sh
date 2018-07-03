#!/bin/bash
ABSOLUTE_FILENAME=`readlink -e "$0"`
DIRECTORY=`dirname "$ABSOLUTE_FILENAME"`
IP=`wget -qO- eth0.me`
INSTALL_ROOT="/opt/tgsocksproxy"
gitlink="https://github.com/alexbers/tgsocksproxy.git"

preinstall() {
#downloading
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install htop git

echo > check_file.cfg
install
}

if [ -e $DIRECTORY/check_file.cfg ]; then 
install; else
preinstall
fi

install() {
if grep "SOCKS" check_file.cfg; then
echo "SOCKS5 уже установлен на вашем сервере! Установка отменена (для сброса данных о установке введите команду: rm check_file.cfg)"
exit 1
fi

usage() {
    echo "Использование: ./installsocks.sh -l <login> -p <password>"
}
LOGIN=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 5 | xargs`
PASSWORD=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 7 | xargs`

while getopts "l:p:" arg; do
	case $arg in
		l)
		LOGIN=$OPTARG
        ;;
		p)
		PASSWORD=$OPTARG
		;;
		*)
		usage
		exit 1
	esac
done

CONFIG="PORT = 1080
USERS = {\"${LOGIN}\": \"${PASSWORD}\"}"

#SOCKS5 setup
cd /opt
sudo mkdir $INSTALL_ROOT
sudo chown $USER $INSTALL_ROOT
git clone $gitlink
cd $INSTALL_ROOT
rm config.py
echo | sed  "i$CONFIG" > config.py
sudo cp $DIRECTORY/SOCKS5.service /etc/systemd/system/
sudo systemctl daemon-reload && sudo systemctl restart SOCKS5.service && sudo systemctl enable SOCKS5.service
finish
}

mtproxy_install() {
read -p "Желаете установить MTProxy? (y/n)" check
if [[check != "y"]]; then
exit 0
else
./install.sh
fi
}

finish() {
cd $DIRECTORY
echo "SOCKS5 " > check_file.cfg
echo "Установка SOCKS5 успешно завершена! Ваша ссылка для подключения: https://t.me/socks?server=${IP}&port=1080&user=${LOGIN}&pass=${PASSWORD}"
echo "IP: ${IP}, port: 1080, login: ${LOGIN}, password: ${PASSWORD}"
if grep "MTProxy" check_file.cfg; then
exit 0
else
mtproxy_install
fi
}