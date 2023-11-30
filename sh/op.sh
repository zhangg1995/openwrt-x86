#!/bin/bash
#=================================================
shopt -s extglob

svn export https://github.com/shiyu1314/openwrt-onecloud/trunk/target/linux/meson target/linux/meson

svn export https://github.com/immortalwrt/immortalwrt/trunk/package/emortal package/emortal

sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages.git;master' feeds.conf.default

sed -i "/telephony/d" feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install -a -p kiddin9 -f
./scripts/feeds install -a

sed -i "s/192.168.1.1/192.168.2.2/" package/base-files/files/bin/config_generate

sed -i "s/192.168.1/192.168.2.2/" package/feeds/kiddin9/base-files/files/bin/config_generate

sed -i "s/Kiddin'/shiyu1314/" package/feeds/kiddin9/base-files/files/etc/banner

sed -i "s/Kiddin'/shiyu1314/" package/feeds/kiddin9/base-files/files/etc/openwrt_release

sed -i '$a ([ -x /bin/bash ] && ! grep -q "^root.*bash" /etc/passwd) && sed -i "s/^\(root.*\/\)ash/\1bash/g" /etc/passwd' package/emortal/default-settings/files/99-default-settings-chinese

sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config
