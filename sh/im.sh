#!/bin/bash
sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile
sed -i 's/KERNEL_PATCHVER:=6.2/KERNEL_PATCHVER:=5.15/g' ./target/linux/x86/Makefile
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
./scripts/feeds update -a
sudo rm -rf feeds/packages/net/mosdns
sudo rm -rf feeds/luci/applications/luci-app-openclash
sudo rm -rf package/emortal/default-settings

./scripts/feeds update -a
./scripts/feeds install -a
