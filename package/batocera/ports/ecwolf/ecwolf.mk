################################################################################
#
# ecwolf
#
################################################################################
# Version.: Commits on Sep 24, 2022
ECWOLF_VERSION = db154c482943e89c16b8d4de23120e66f5312042
ECWOLF_SITE = https://bitbucket.org/ecwolf/ecwolf.git
ECWOLF_SITE_METHOD=git
ECWOLF_GIT_SUBMODULES=YES
ECWOLF_LICENSE = Non-commercial
ECWOLF_DEPENDENCIES = host-ecwolf sdl2 sdl2_mixer sdl2_net zlib bzip2 jpeg
ECWOLF_SUPPORTS_IN_SOURCE_BUILD = NO

# We need the tools from the host package to build the target package
HOST_ECWOLF_DEPENDENCIES = zlib bzip2
HOST_ECWOLF_CONF_OPTS += -DTOOLS_ONLY=ON
HOST_ECWOLF_SUPPORTS_IN_SOURCE_BUILD = NO

ECWOLF_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release -DGPL=ON -DFORCE_CROSSCOMPILE=ON \
  -DINTERNAL_SDL_MIXER=ON \
  -DIMPORT_EXECUTABLES="$(HOST_ECWOLF_BUILDDIR)/ImportExecutables.cmake"

# Copy the headers that are usually generated on the target machine
# but must be provided when cross-compiling.
define ECWOLF_COPY_GENERATED_HEADERS
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/ports/ecwolf/*.h $(ECWOLF_BUILDDIR)/deps/gdtoa/
endef

ECWOLF_POST_CONFIGURE_HOOKS += ECWOLF_COPY_GENERATED_HEADERS

define ECWOLF_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/usr/share/ecwolf
	$(INSTALL) -D -m 0755 $(@D)/buildroot-build/ecwolf $(TARGET_DIR)/usr/share/ecwolf/ecwolf
	cp -a $(@D)/buildroot-build/ecwolf.pk3 $(TARGET_DIR)/usr/share/ecwolf/
	ln -sf /usr/share/ecwolf/ecwolf $(TARGET_DIR)/usr/bin/ecwolf

	# evmap config
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/ports/ecwolf/ecwolf.keys $(TARGET_DIR)/usr/share/evmapy
endef

$(eval $(cmake-package))
$(eval $(host-cmake-package))
