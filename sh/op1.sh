#!/bin/bash


echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default

svn export https://github.com/shiyu1314/openwrt-onecloud/trunk/target/linux/meson target/linux/meson

svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

svn export https://github.com/shiyu1314/openwrt-onecloud/trunk/default-settings package/default-settings
