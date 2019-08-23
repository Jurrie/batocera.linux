################################################################################
#
# MUPEN64PLUS-NEXT
#
################################################################################
# Version: Commits on Aug 23, 2019
LIBRETRO_MUPEN64PLUS_NEXT_VERSION = b785150465048fa88f812e23462f318e66af0be0
LIBRETRO_MUPEN64PLUS_NEXT_SITE = $(call github,libretro,mupen64plus-libretro-nx,$(LIBRETRO_MUPEN64PLUS_NEXT_VERSION))
LIBRETRO_MUPEN64PLUS_NEXT_LICENSE = GPLv2
LIBRETRO_MUPEN64PLUS_NEXT_DEPENDENCIES = host-nasm

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	LIBRETRO_MUPEN64PLUS_DEPENDENCIES += rpi-userland
endif

LIBRETRO_MUPEN64PLUS_NEXT_SUPP_OPT=

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=rpi3

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI2),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4)$(BR2_PACKAGE_BATOCERA_TARGET_LEGACYXU4),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=odroid-ODROID-XU

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_C2),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=odroid-ODROIDC

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S905),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=unix
	LIBRETRO_MUPEN64PLUS_NEXT_SUPP_OPT=ARCH=aarch64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S912),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=unix
	LIBRETRO_MUPEN64PLUS_NEXT_SUPP_OPT=ARCH=aarch64

else ifeq ($(BR2_x86_i586),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=unix
	LIBRETRO_MUPEN64PLUS_NEXT_SUPP_OPT=ARCH=i686

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCKPRO64),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=rockpro64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDN2),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=odroidn2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_TINKERBOARD),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=tinkerboard

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_MIQI),y)
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=miqi

else
	LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM=$(LIBRETRO_PLATFORM)
endif

define LIBRETRO_MUPEN64PLUS_NEXT_BUILD_CMDS
	PATH=$(BR_PATH) CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" CPPFLAGS="$(TARGET_CPPFLAGS)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" \
		RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)/ \
		-f Makefile platform="$(LIBRETRO_MUPEN64PLUS_NEXT_PLATFORM)" \
		$(LIBRETRO_MUPEN64PLUS_NEXT_SUPP_OPT)
endef

define LIBRETRO_MUPEN64PLUS_NEXT_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mupen64plus_next_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mupen64plus-next_libretro.so
endef

$(eval $(generic-package))
