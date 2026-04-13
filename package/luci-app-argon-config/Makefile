include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-argon-config
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=
PKG_MAINTAINER:=local

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=Themes
  TITLE:=Argon theme configuration panel
  DEPENDS:=+luci-base +rpcd +rpcd-mod-file
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/argon $(1)/etc/config/argon

	$(INSTALL_DIR) $(1)/www/luci-static/resources/view
	$(INSTALL_DATA) ./files/www/luci-static/resources/view/argon-config.js $(1)/www/luci-static/resources/view/argon-config.js

	$(INSTALL_DIR) $(1)/usr/libexec/rpcd
	$(INSTALL_BIN) ./files/usr/libexec/rpcd/luci.argon $(1)/usr/libexec/rpcd/luci.argon

	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d
	$(INSTALL_DATA) ./files/usr/share/luci/menu.d/luci-app-argon-config.json $(1)/usr/share/luci/menu.d/luci-app-argon-config.json

	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./files/usr/share/rpcd/acl.d/luci-app-argon-config.json $(1)/usr/share/rpcd/acl.d/luci-app-argon-config.json

	$(INSTALL_DIR) $(1)/www/luci-static/argon/background
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

