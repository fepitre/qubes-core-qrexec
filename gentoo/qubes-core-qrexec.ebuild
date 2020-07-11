# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=6

inherit git-r3 eutils multilib

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-core-qrexec.git"
EGIT_COMMIT="v${PV}"
DESCRIPTION="The Qubes qrexec files (qube side)"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPLv2"

SLOT="0"
IUSE=""


DEPEND="dev-python/setuptools \
        dev-python/sphinx \
        dev-python/dbus-python \
        sys-libs/pam \
        app-emulation/qubes-libvchan-xen"
# WIP: currently ignore pandoc for time saving
#        app-text/pandoc"
RDEPEND="$DEPEND"
PDEPEND=""

src_prepare() {
    einfo "Apply patch set"
    EPATCH_SUFFIX="patch" \
    EPATCH_FORCE="yes" \
    EPATCH_OPTS="-p1" \
    epatch "${FILESDIR}"

    default
}

src_compile() {
    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen PYTHON=python3.7 LIBDIR=/usr/$(get_libdir)"
    # WIP: currently ignore pandoc for time saving
    myopt="${myopt} PANDOC=touch"
    emake ${myopt} all-base
    emake ${myopt} all-vm
}

src_install() {
    emake ${myopt} install-base
    emake ${myopt} install-vm
}

pkg_postinst() {
    systemctl enable qubes-qrexec-agent.service
}

pkg_postrm() {
    systemctl disable qubes-qrexec-agent.service
}