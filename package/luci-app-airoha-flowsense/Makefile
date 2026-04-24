# This is free software, licensed under the Apache License, Version 2.0 .

include $(TOPDIR)/rules.mk

PKG_VERSION:=1.1.3
PKG_RELEASE:=3
PKG_LICENSE:=Apache-2.0

LUCI_TITLE:=LuCI Airoha FlowSense -- Offload & PPE Monitor
LUCI_DEPENDS:=+luci-base @TARGET_airoha

include ../../feeds/luci/luci.mk

define Package/luci-app-airoha-flowsense/conffiles
/etc/config/npu-monitor
endef



define Package/luci-app-airoha-flowsense/postinst
#!/bin/sh
chmod +x /usr/libexec/rpcd/luci.airoha_flowsense 2>/dev/null
chmod +x /usr/libexec/npu-jitter-daemon 2>/dev/null
chmod +x /etc/init.d/npu-jitter 2>/dev/null
[ -x /etc/init.d/npu-jitter ] && /etc/init.d/npu-jitter enable && /etc/init.d/npu-jitter start
[ -n "$${IPKG_INSTROOT}" ] || {
	rm -f /tmp/luci-indexcache.*
	rm -rf /tmp/luci-modulecache/
	/etc/init.d/rpcd restart 2>/dev/null
	exit 0
}
endef

# call BuildPackage - OpenWrt buildroot signature
