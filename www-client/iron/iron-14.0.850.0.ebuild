# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvs/zport/sci-mathematics/pvs/pvs-3.2.ebuild,v 1.1.1.1 2006/11/22 16:05:34 zechs Exp $

EAPI="2"
inherit eutils

DESCRIPTION="SRWare Iron web browser -- chromium-based browser"
HOMEPAGE="http://srware,net/"
SRC_HEAD="http://srware.net/downloads/${PN}"
SRC_URI="amd64? ( ${SRC_HEAD}-linux-64.tar.gz ) x86? ( ${SRC_HEAD}-linux.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"

IUSE=""
RDEPEND="app-arch/bzip2
	app-misc/ca-certificates
	media-libs/alsa-lib
	dev-libs/atk
	dev-libs/dbus-glib
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libxslt
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/fontconfig
	media-libs/freetype
	net-print/cups
	media-libs/libpng:1.2
	sys-apps/dbus
	>=sys-devel/gcc-4.4.0[-nocxx]
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXext
	x11-libs/pango
	x11-misc/xdg-utils"

src_unpack() {
	unpack "${A}"
}

src_install() {
	dodir "/opt/srware-iron"
	cp -pPR ${WORKDIR}/iron-linux*/* ${D}/opt/srware-iron

	dodir "/usr/bin"
	dosym "/opt/srware-iron/iron" "/usr/bin/iron"
	dosym "../../usr/lib/nsbrowser/plugins" "/opt/srware-iron/plugins"
}

