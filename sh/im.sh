#!/bin/bash

#git clone https://github.com/kiddin9/openwrt-packages.git
#cp -rf openwrt-packages/luci-app-openclash package/luci-app-openclash
#cp -rf openwrt-packages/luci-app-adguardhome package/luci-app-adguardhome
#rm -rf openwrt-packages
#echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default

#echo 'src-git small https://github.com/kenzok8/small-package.git' >>feeds.conf.default
sed -i "s/192.168.1.1/192.168.3.254/" package/base-files/files/bin/config_generate

./scripts/feeds update -a
./scripts/feeds install -a

#下载oc核心
mkdir -p files/etc/openclash/core
CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz"
CLASH_TUN_URL=$(curl -fsSL https://api.github.com/repos/vernesong/OpenClash/contents/master/premium\?ref\=core | grep download_url | grep amd64 | awk -F '"' '{print $4}')
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
GEO_MMDB_URL="https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb"

wget -qO- $CLASH_DEV_URL | tar xOvz > files/etc/openclash/core/clash
wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
wget -qO- $GEO_MMDB_URL > files/etc/openclash/Country.mmdb

chmod +x files/etc/openclash/core/clash*

#sed -i 's/$(TARGET_DIR)) install/$(TARGET_DIR)) install --force-overwrite --force-depends/' package/Makefile
