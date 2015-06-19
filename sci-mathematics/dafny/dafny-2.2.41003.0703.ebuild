# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvs/zport/sci-mathematics/pvs/pvs-3.2.ebuild,v 1.1.1.1 2006/11/22 16:05:34 zechs Exp $

EAPI=3

inherit eutils

DESCRIPTION="Dafny: a language and program verifier for functional correctness"
HOMEPAGE="http://research.microsoft.com/en-us/projects/dafny/"
SRC_URI="${PN}-${PV}.zip"

LICENSE="Ms-PL"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""
RDEPEND="
	>=dev-lang/mono-2.8
	>=sci-mathematics/z3-2.2
	sys-apps/grep"

RESTRICT="fetch strip"

pkg_nofetch() {
	einfo "Codeplex does not provide an ability to download boogie/dafny."
	einfo "You should download appropriate boogie-archive and place it to ${DISTDIR}/${SRC_URI}"
}

src_install() {
	DAFNY_DIR="/opt/dafny"
	Z3_PLACE="../../usr/bin/z3"

	dodir "${DAFNY_DIR}"
	cp -pPR "${WORKDIR}"/* "${D}${DAFNY_DIR}"

	rm -f "${D}${DAFNY_DIR}"/*.pdb

	dosym "${Z3_PLACE}" "${DAFNY_DIR}/z3.exe"

	echo '#!/bin/sh

if [[ "$1" == "-s" ]]; then
    COMMAND_SUFFIX=" | grep -v \"Execution trace:\|): anon\""

    shift
else
    COMMAND_SUFFIX=""
fi

RUNCOMMAND="mono /opt/dafny/Dafny.exe"

COMMAND=""
while [[ "$#" > 0 ]]; do
    COMMAND=$COMMAND" "\""$1"\"
    shift
done
COMMAND="$RUNCOMMAND$COMMAND$COMMAND_SUFFIX"

eval $COMMAND' > "${WORKDIR}/dafny"
	dobin ${WORKDIR}/dafny
}
