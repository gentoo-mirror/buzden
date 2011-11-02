# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvs/zport/sci-mathematics/pvs/pvs-3.2.ebuild,v 1.1.1.1 2006/11/22 16:05:34 zechs Exp $

inherit eutils

EAPI=2

DESCRIPTION="PVS - a theorem prover for formal specification and verification"
HOMEPAGE="http://pvs.csl.sri.com/"
SRC_HEAD="http://pvs.csl.sri.com/cgi-bin/download.cgi?accept=I+accept&file=${PN}-${PV}"
SRC_URI="amd64? ( ${SRC_HEAD}-ix86_64-Linux-allegro.tgz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"

IUSE=""
RDEPEND="app-editors/emacs[X]"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /opt/pvs
	cp -pPR ${WORKDIR}/* ${D}/opt/pvs

	dodir /usr/bin
	dosym /opt/pvs/pvs /usr/bin/pvs
	dosym /opt/pvs/proveit /usr/bin/proveit
	dosym /opt/pvs/provethem /usr/bin/provethem
}

pkg_postinst() {
	cd /opt/pvs
	bin/relocate
}
