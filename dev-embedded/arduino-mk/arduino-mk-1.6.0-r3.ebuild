# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="Arduino-Makefile"

DESCRIPTION="Makefile for Arduino sketches."
HOMEPAGE="https://github.com/sudar/Arduino-Makefile"
SRC_URI="https://github.com/sudar/${MY_PN}/archive/${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+monitor doc examples"

COMMONDEP="
dev-embedded/arduino
dev-python/pyserial"

RDEPEND="${COMMONDEP}
dev-embedded/avrdude
monitor? (
	app-misc/screen
)"

DEPEND="${COMMONDEP}"

PATCHES=(
	"${FILESDIR}/${P}-105-commits-after.patch"
	"${FILESDIR}/${P}-no-bossa-debug.patch"
)

src_unpack(){
	unpack ${A}
	cd ../"${S}"
	mv ${MY_PN}-${PV} ${PN}-${PV}
}

src_install(){
	dobin bin/*
	doman *.1

	insinto /usr/share/arduino-mk
	doins *.mk

	if use doc; then
		dodoc HISTORY.md README.md arduino-mk-vars.md
	fi
	if use examples; then
		dodoc -r examples
	fi
}
