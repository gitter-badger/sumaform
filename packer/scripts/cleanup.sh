yum -y erase gtk2 libX11 hicolor-icon-theme freetype bitstream-vera-fonts
yum -y clean all

# Remove traces of mac address from network configuration
sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
rm -f /etc/udev/rules.d/70-persistent-net.rules
