# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvs/zport/sci-mathematics/pvs/pvs-3.2.ebuild,v 1.1.1.1 2006/11/22 16:05:34 zechs Exp $

EAPI=3

inherit eutils

DESCRIPTION="DRAKON editor"
HOMEPAGE="http://drakon-editor.sourceforge.net/editor.html"
SRC_URI="http://sourceforge.net/projects/drakon-editor/files/drakon_editor${PV}_rus.zip"

SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""
RDEPEND="
	=dev-lang/tcl-8.6*
	=dev-lang/tk-8.6*
	dev-tcltk/tcllib
	dev-db/sqlite[tcl]
	dev-tcltk/tkimg"

src_unpack() {
	mkdir -p ${S}
	unzip ${DISTDIR}/${A} -d ${S} || die
}

src_install() {
	DRAKON_DIR="/opt/${PN}"

	dodir ${DRAKON_DIR}
	
	cp -pPR "${S}"/* "${D}${DRAKON_DIR}"

	into /opt
	dobin ${FILESDIR}/drakon_editor
	dobin ${FILESDIR}/drakon_gen
}
