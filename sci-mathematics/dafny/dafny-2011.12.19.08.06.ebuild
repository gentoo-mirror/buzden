# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvs/zport/sci-mathematics/pvs/pvs-3.2.ebuild,v 1.1.1.1 2006/11/22 16:05:34 zechs Exp $

inherit eutils

EAPI=4

DESCRIPTION="Dafny: a language and program verifier for functional correctness"
HOMEPAGE="http://research.microsoft.com/en-us/projects/dafny/"
SRC_URI="${PN}-${PV}.zip"

LICENSE="Ms-PL"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""
RDEPEND="
	>=dev-lang/mono-2.8
	>=sci-mathematics/z3-2.2"

RESTRICT="fetch strip"

pkg_nofetch() {
	einfo "Codeplex does not provide an ability to download boogie/dafny."
	einfo "You should download appropriate boogie-archive and place it to ${DISTDIR}/${SRC_URI}"
}

src_unpack() {
	unpack ${A}
}

src_install() {
	DAFNY_DIR="/opt/dafny"

	dodir "${DAFNY_DIR}"
	cp -pPR "${WORKDIR}"/* "${D}${DAFNY_DIR}"

	rm -f "${D}${DAFNY_DIR}"/*.pdb
	rm -f "${D}${DAFNY_DIR}"/Provers.Isabelle.*
	rm -f "${D}${DAFNY_DIR}"/Provers.Simplify.*
	rm -f "${D}${DAFNY_DIR}"/Provers.TPTP.*

	rename Provers.SMTLib Provers.SMTLIB "${WORKDIR}"/*

	dosym "/usr/bin/z3" "${D}${DAFNY_DIR}/z3.exe"

	# TODO to create ${WORKDIR}/dafny
	#dobin ${WORKDIR}/dafny
}

pkg_postinst() {
	cd /opt/pvs
	bin/relocate
}
