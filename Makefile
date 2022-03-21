include $(TOPDIR)/rules.mk

PKG_NAME:=watchwifi
PKG_SOURCE_VERSION:=de817a0d7830760cae845243bf92f33d1ac34fc2
PKG_SOURCE_DATE=2022-03-21
PKG_RELEASE:=v1.0
PKG_MAINTAINER:=Michael Foxworthy <mfoxworthy@ipsquared.com>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git@github.com:mfoxworthy/watchwifi.git
PKG_MIRROR_HASH:=skip

PKG_LICENSE:=GPLv3

include $(INCLUDE_DIR)/package.mk

define Package/watchwifi
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+jq
  TITLE:=watchwifi - Watchdog for radio interfaces
  PKGARCH:=all
endef

define Package/watchwifi/description
  Watchwifi is a simple watchdog utility to bounce a wifi interface that is down when required to be up.
endef

define Build/Compile
endef

define Package/watchwifi/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/watchwifi.init  $(1)/etc/init.d/watchwifi

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/watchwifi $(1)/usr/lib

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/watchwifi.config  $(1)/etc/config/watchwifi

endef

define Package/watchwifi/postinst
#!/bin/sh
/etc/init.d/watchwifi enable
/etc/init.d/watchwifi start
exit 0
endef

$(eval $(call BuildPackage,watchwifi))
