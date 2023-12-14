#!/bin/bash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
./scripts/feeds update -a
sudo rm -rf feeds/packages/net/mosdns
sudo rm -rf feeds/luci/applications/luci-app-openclash
sudo rm -rf package/emortal/default-settings

./scripts/feeds update -a
./scripts/feeds install -a
