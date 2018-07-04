<<<<<<< HEAD
#!/bin/bash
AD_TAG=$1
cd /opt/mtprotoproxy

if [ -n "$AD_TAG" ]; then
AD_TAG=$AD_TAG; else
echo "Ошибка! Вы не ввели AD_TAG (./set_AD_TAG.sh <AD_TAG>)"
fi

CONFIG=$(cat /opt/mtprotoproxy/config.py)
TRUE_CONFIG="${CONFIG}\nAD_TAG = \"${AD_TAG}\""

if [ -z `echo $AD_TAG | grep -x '[[:xdigit:]]\{32\}'` ]; then
    echo "AD_TAG должен быть 32-значным ключом, содержащим только HEX-символы"
exit 1
else
echo | sed  "i$TRUE_CONFIG" > config.py
=======
#!/bin/bash
AD_TAG=$1
cd /opt/mtprotoproxy

if [ -n "$AD_TAG" ]; then
AD_TAG=$AD_TAG; else
echo "Ошибка! Вы не ввели AD_TAG (./set_AD_TAG.sh <AD_TAG>)"
fi

CONFIG=$(cat /opt/mtprotoproxy/config.py)
TRUE_CONFIG="${CONFIG}\nAD_TAG = \"${AD_TAG}\""

if [ -z `echo $AD_TAG | grep -x '[[:xdigit:]]\{32\}'` ]; then
    echo "AD_TAG должен быть 32-значным ключом, содержащим только HEX-символы"
exit 1
else
echo | sed  "i$TRUE_CONFIG" > config.py
>>>>>>> ec04d8d9fe2fd449f1f26d4fb5b2678ee3356afa
fi