#!/bin/bash

svn export https://github.com/shiyu1314/openwrt-onecloud/trunk/target/linux/meson target/linux/meson

svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

svn export https://github.com/shiyu1314/openwrt-onecloud/trunk/default-settings package/default-settings

svn export https://github.com/shiyu1314/openwrt-onecloud/trunk/kernel include --force

echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default


./scripts/feeds update -a
sudo rm -rf feeds/packages/net/mosdns
sudo rm -rf feeds/luci/applications/luci-app-openclash
sudo rm -rf package/emortal/default-settings

./scripts/feeds update -a
./scripts/feeds install -a

sed -i "s/192.168.1.1/192.168.2.2/" package/base-files/files/bin/config_generate
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

sudo rm -rf package/base-files/files/etc/banner

sed -i "s/%D %V %C/%D $(TZ=UTC-8 date +%Y.%m.%d)/" package/base-files/files/etc/openwrt_release

sed -i "s/%R/by shiyu1314/" package/base-files/files/etc/openwrt_release


date=$(date +"%Y-%m-%d")
echo "                                                    " >> package/base-files/files/etc/banner
echo ".___                               __         .__" >> package/base-files/files/etc/banner
echo "|   | _____   _____   ____________/  |______  |  |" >> package/base-files/files/etc/banner
echo "|   |/     \ /     \ /  _ \_  __ \   __\__  \ |  |" >> package/base-files/files/etc/banner
echo "|   |  Y Y  \  Y Y  (  <_> )  | \/|  |  / __ \|  |__" >> package/base-files/files/etc/banner
echo "|___|__|_|  /__|_|  /\____/|__|   |__| (____  /____/" >> package/base-files/files/etc/banner
echo "          \/      \/                        \/      " >> package/base-files/files/etc/banner
echo " -----------------------------------------------------" >> package/base-files/files/etc/banner
echo "         %D ${date} by shiyu1314                     " >> package/base-files/files/etc/banner
echo " -----------------------------------------------------" >> package/base-files/files/etc/banner
echo "                                                      " >> package/base-files/files/etc/banner
