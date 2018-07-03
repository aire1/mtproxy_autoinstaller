# MTProtoproxy auto-installer #

Simple and very fast installer for mtprotoproxy.

## Requirements ##

You must have open 443 and 1080 ports.

## How to install? ##

1. `git clone https://github.com/aire1/mtproxy_autoinstaller.git; cd mtproxy_autoinstaller`
2. `sudo chmod ugo+x install.sh && sudo chmod ugo+x socks_install.sh`
3. `./install.sh` (or `./socks_install.ah` if you want to install socks5 proxy)
4. Just copy link and use your proxy!

## Advanced usage ##
- You can set your own secret for MTProxy (it should be 32-chars HEX 0-9 a-f), just write it after `./install.sh` 
(`./install.sh <secret>`)
- You can set your own login and password for socks5 proxy, just just write it after `./socks_install.sh` 
(`./install.sh <login <password>>`)
