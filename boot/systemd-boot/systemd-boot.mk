################################################################################
#
# systemd-boot -  Bootloader Only
#
################################################################################

SYSTEMD_BOOT_VERSION = $(SYSTEMD_VERSION)
SYSTEMD_BOOT_SITE = $(call github,systemd,systemd,v$(SYSTEMD_BOOT_VERSION))
SYSTEMD_BOOT_SOURCE = systemd-$(SYSTEMD_BOOT_VERSION).tar.gz
SYSTEMD_BOOT_LICENSE = $(SYSTEMD_LICENSE)
SYSTEMD_BOOT_LICENSE_FILES =  $(SYSTEMD_LICENSE_FILES)
SYSTEMD_BOOT_CPE_ID_VALID = YES
SYSTEMD_BOOT_INSTALL_TARGET = NO
SYSTEMD_BOOT_INSTALL_IMAGES = YES
SYSTEMD_BOOT_DEPENDENCIES =  \
                            host-pkgconf host-meson \
                            host-ninja host-python-jinja2 \
                            host-python-pyelftools \
                            gnu-efi libcap libxcrypt util-linux-libs

#meson options : Disable everything except the bootloader/efi
SYSTEMD_BOOT_CONF_OPTS = \
	-Dstandalone-binaries=false \
	-Defi=true \
	-Dbootloader=enabled \
	-Dmode=release \
	-Dman=disabled \
	-Dtests=false \
	-Dsysusers=false \
	-Dtmpfiles=false \
	-Dhwdb=false \
	-Dglib=disabled \
	-Dlibarchive=disabled \
	-Dacl=disabled \
	-Dapparmor=disabled \
	-Daudit=disabled \
	-Dlibcryptsetup=disabled \
	-Dlibcryptsetup-plugins=disabled \
	-Delfutils=disabled \
	-Dlibiptc=disabled \
	-Dlibidn=disabled -Dlibidn2=disabled \
	-Dseccomp=disabled \
	-Dxkbcommon=disabled \
	-Dbzip2=disabled \
	-Dzstd=disabled \
	-Dlz4=disabled \
	-Dpam=disabled \
	-Dfdisk=disabled \
	-Dkmod=disabled \
	-Dxz=disabled \
	-Dzlib=disabled \
	-Dlibcurl=disabled \
	-Dgcrypt=disabled \
	-Dp11kit=disabled \
	-Dpcre2=disabled \
	-Dblkid=disabled \
	-Dinitrd=false \
	-Dkernel-install=false \
	-Danalyze=false \
	-Dpwquality=disabled \
	-Dremote=disabled -Dmicrohttpd=disabled \
	-Dqrencode=disabled \
	-Dselinux=disabled \
	-Dhwdb=false \
	-Dbinfmt=false \
	-Dutmp=false \
	-Dvconsole=false \
	-Dvmspawn=disabled \
	-Dquotacheck=false \
	-Dsysusers=false \
	-Dstoragetm=false \
	-Dfirstboot=false \
	-Drandomseed=false \
	-Dbacklight=false \
	-Drfkill=false \
	-Dlogind=false \
	-Dmachined=false -Dnss-mymachines=disabled \
	-Dimportd=disabled \
	-Dhomed=disabled \
	-Dhostnamed=false \
	-Dnsresourced=false \
	-Dnss-myhostname=false \
	-Dtimedated=false \
	-Dlocaled=false \
	-Drepart=disabled \
	-Dmountfsd=false \
	-Duserdb=false \
	-Dcoredump=false \
	-Dpstore=false \
	-Doomd=false \
	-Dpolkit=disabled \
	-Dportabled=false \
	-Dsysext=false \
	-Dsysupdate=disabled \
	-Dnetworkd=false \
	-Dnss-resolve=disabled -Dresolve=false \
	-Dtimesyncd=false \
	-Dsmack=false \
	-Dhibernate=false \
	-Dtpm2=disabled \
	-Dtests=false \
	-Dbpf-framework=disabled \
	-Dauto_features=disabled

SYSTEMD_BOOT_EFI_ARCH = $(call qstrip,$(BR2_PACKAGE_SYSTEMD_BOOT_EFI_ARCH))

define SYSTEMD_BOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/buildroot-build/src/boot/systemd-boot$(SYSTEMD_BOOT_EFI_ARCH).efi \
		$(BINARIES_DIR)/efi-part/EFI/BOOT/boot$(SYSTEMD_BOOT_EFI_ARCH).efi
	$(INSTALL) -D -m 0644 $(SYSTEMD_BOOT_PKGDIR)/boot-files/loader.conf \
		$(BINARIES_DIR)/efi-part/loader/loader.conf
	$(INSTALL) -D -m 0644 $(SYSTEMD_BOOT_PKGDIR)/boot-files/buildroot.conf \
		$(BINARIES_DIR)/efi-part/loader/entries/buildroot.conf
endef

$(eval $(meson-package))
