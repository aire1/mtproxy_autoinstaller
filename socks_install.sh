#!/bin/bash
ABSOLUTE_FILENAME=`readlink -e "$0"`
DIRECTORY=`dirname "$ABSOLUTE_FILENAME"`
IP=`wget -qO- eth0.me`
INSTALL_ROOT="/opt/tgsocksproxy"
gitlink="https://github.com/alexbers/tgsocksproxy.git"
LOGIN=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 5 | xargs`
PASSWORD=`tr -dc A-Za-z0-9 < /dev/urandom | head -c 7 | xargs`
finish() {
cd $DIRECTORY
echo "SOCKS " > check_file.cfg
echo "Установка SOCKS5 успешно завершена! Ваша ссылка для подключения: https://t.me/socks?server=${IP}&port=1080&user=${LOGIN}&pass=${PASSWORD}"
}

generate() {
usage() {
    echo "Использование: ./installsocks.sh -l <login> -p <password>"
}
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
}

install() {
if grep -q "SOCKS" check_file.cfg; then
echo "SOCKS5 уже установлен на вашем сервере! Установка отменена (для сброса данных о установке введите команду: rm check_file.cfg)"
exit 1
fi

generate

CONFIG="PORT = 1080\nUSERS = {\"${LOGIN}\": \"${PASSWORD}\"}"

writing(){
cd $INSTALL_ROOT
rm config.py
echo | sed  "i$CONFIG" > config.py
}

#SOCKS5 setup
cd /opt
sudo mkdir $INSTALL_ROOT
sudo chown $USER $INSTALL_ROOT
git clone $gitlink
writing
sudo cp $DIRECTORY/SOCKS5.service /etc/systemd/system/
sudo systemctl daemon-reload && sudo systemctl restart SOCKS5.service && sudo systemctl enable SOCKS5.service
finish
}

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