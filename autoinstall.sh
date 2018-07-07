#!/bin/sh

sudo apt update && sudo apt install -y git

echo '\n--------------------------------------'
echo '\tCLONING'
echo '--------------------------------------\n'

git clone -b stable https://github.com/aire1/mtproxy_autoinstaller; cd mtproxy_autoinstaller

sudo chmod ugo+x install.sh && sudo chmod ugo+x socks_install.sh && sudo chmod ugo+x set_AD_TAG.sh

echo '\n--------------------------------------'
echo '\tCONFIGURE MTPROXY'
echo '--------------------------------------\n'

./install.sh