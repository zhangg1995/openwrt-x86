#!/bin/bash
#=================================================
sudo rm -rf feeds/packages/net/mosdns
sudo rm -rf feeds/luci/applications/luci-app-openclash
sudo rm -rf package/emortal/default-settings
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

