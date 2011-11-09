# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="CVC3"
HOMEPAGE="http://www.cs.nyu.edu/acsys/cvc3/"
SRC_URI="http://www.cs.nyu.edu/acsys/cvc3/releases/2.4.1/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="
	>=sys-devel/gcc-3.0
	app-shells/bash
	sys-devel/flex
	sys-devel/bison
	dev-libs/gmp"
RDEPEND="${DEPEND}"

# TODO to add use flags "gmp" and "java" and to make appropriate dependencies
# about it.

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}
