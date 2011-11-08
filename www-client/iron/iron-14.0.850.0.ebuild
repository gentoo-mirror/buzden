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
DEPEND="
	x11-libs/libXScrnSaver
	x11-libs/gtk+
	dev-libs/nss
	gnome-base/gconf
	=media-libs/libpng-1.2.46"
	# TODO to know what other libraries are used.

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /opt/srware-iron
	cp -pPR ${WORKDIR}/iron-linux*/* ${D}/opt/srware-iron

	dodir /usr/bin
	dosym /opt/srware-iron/iron /usr/bin/iron
}

