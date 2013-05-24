# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/scala/scala-2.9.2.ebuild,v 1.2 2012/08/20 03:00:19 ottxor Exp $

EAPI="3"
inherit eutils check-reqs java-pkg-2 java-ant-2 versionator

IUSE="binary source emacs"

DESCRIPTION="The Scala Programming Language"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="binary? ( ${HOMEPAGE}downloads/distrib/files/${P}.tgz )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="virtual/jdk:1.6
	java-virtuals/jdk-with-com-sun
	app-arch/xz-utils"
RDEPEND=">=virtual/jre-1.6
	!dev-java/scala-bin"

PDEPEND="emacs? ( app-emacs/scala-mode )"

pkg_setup() {
	if ! use binary; then
	    eerror "Non-binary build is not supported"

		die
	fi
}

src_compile() {
	einfo "Skipping compilation, USE=binary is set."
}

src_install() {
	local SCALADIR="/usr/share/${PN}/"

	exeinto "${SCALADIR}/bin"
	doexe $(find bin/ -type f ! -iname '*.bat')

	java-pkg_dojar lib/*.jar

	if use source; then
		dodir "${SCALADIR}/src"
		insinto "${SCALADIR}/src"
		doins src/*-src.jar
	fi

	doman man/man1/*.1 || die

	dodir /usr/bin
	for b in $(find bin/ -type f ! -iname '*.bat'); do
		local _name=$(basename "${b}")
		dosym "/usr/share/${PN}/bin/${_name}" "/usr/bin/${_name}"
	done
}
