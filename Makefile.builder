RPM_SPEC_FILES = rpm_spec/qubes-qrexec.spec

ifeq ($(PACKAGE_SET),dom0)
RPM_SPEC_FILES += rpm_spec/qubes-qrexec-dom0.spec
else
RPM_SPEC_FILES += rpm_spec/qubes-qrexec-vm.spec
endif

EBUILD_FILES := gentoo/qubes-core-qrexec.ebuild
DEBIAN_BUILD_DIRS = debian

# vim: ft=make
