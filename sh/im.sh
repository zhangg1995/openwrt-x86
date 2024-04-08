#!/bin/bash
git clone https://github.com/kiddin9/openwrt-packages.git
cp -rf openwrt-packages/luci-app-openclash package/luci-app-openclash
cp -rf openwrt-packages/adguardhome package/adguardhome
cp -rf openwrt-packages/luci-app-adguardhome package/luci-app-adguardhome
rm -rf openwrt-packages
echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
sed -i "s/192.168.1.1/192.168.3.254/" package/base-files/files/bin/config_generate

./scripts/feeds update -a
./scripts/feeds install -a
