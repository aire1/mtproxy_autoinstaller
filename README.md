# MTProxy and SOCKS5 auto installer

Simple and very fast installer for mtprotoproxy.

# Get Started

### Requirements

If you want to install MTProxy, open 1443 port, if you want to install SOCKS5, open 1080 port.

## How to install MTProxy (user friendly)?

1. `curl -s https://raw.githubusercontent.com/aire1/mtproxy_autoinstaller/stable/autoinstall.sh | sh` and get your personal MTProxy.       

### How to install (manual)?
1. `git clone -b stable https://github.com/aire1/mtproxy_autoinstaller.git; cd mtproxy_autoinstaller`
2. `sudo chmod ugo+x install.sh && sudo chmod ugo+x socks_install.sh && sudo chmod ugo+x set_AD_TAG.sh`
3. `./install.sh` (or `./socks_install.sh` if you want to install socks5 proxy)
4. Just copy link and use your proxy!

### Advanced install
- You can set your own secret for MTProxy (it should be 32-chars HEX 0-9 a-f), just write it after `./install.sh`
(`./install.sh <secret>`)
- You can set your own login and password for socks5 proxy, just write it after `./socks_install.sh`          
(`./socks_install.sh <login> <password>`)
- Of course you can set your own AD_TAG, just write if after `./set_AD_TAG.sh`                 
(`./set_AD_TAG.sh <AD_TAG>`)

# License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
