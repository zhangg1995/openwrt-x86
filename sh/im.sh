#!/bin/bash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome
echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default

./scripts/feeds update -a
./scripts/feeds install -a
