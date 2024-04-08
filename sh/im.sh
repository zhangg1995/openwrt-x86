#!/bin/bash
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../
  cd .. && rm -rf $repodir
}

git_sparse_clone master https://github.com/shiyu1314/openwrt-packages luci-app-adguardhome
mv -f luci-app-adguardhome package

git clone https://github.com/kiddin9/openwrt-packages.git
cp -rf openwrt-packages/luci-app-openclash package/luci-app-openclash
rm -rf openwrt-packages
echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
sed -i "s/192.168.1.1/192.168.3.254/" package/base-files/files/bin/config_generate

./scripts/feeds update -a
./scripts/feeds install -a
