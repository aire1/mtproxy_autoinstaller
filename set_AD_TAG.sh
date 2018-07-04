#!/bin/bash

AD_TAG=$1

cd /opt/mtprotoproxy

if [ -n "$AD_TAG" ]; then

AD_TAG=$AD_TAG; else

echo "Ошибка! Вы не ввели AD_TAG (./set_AD_TAG.sh <AD_TAG>)"

exit 1
<<<<<<< HEAD

fi

CONFIG=`cat /opt/mtprotoproxy/config.py`

TRUE_CONFIG="${CONFIG}\nAD_TAG = \"${AD_TAG}\""

if [ -z `echo $AD_TAG | grep -x '[[:xdigit:]]\{32\}'` ]; then

    echo "AD_TAG должен быть 32-значным ключом, содержащим только HEX-символы"

	exit 1
else

echo -e "$TRUE_CONFIG" > config.py
fi
else
echo | sed  "i$TRUE_CONFIG" > config.py
fi
=======
else
echo | sed  "i$TRUE_CONFIG" > config.py
fi
>>>>>>> ebab0ee53d6e2bbe03f27dacc529b7a4e8d1e859
