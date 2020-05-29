# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils

SLOT="0"

KEYWORDS="~amd64"
SRC_URI="https://isabelle.in.tum.de/dist/Isabelle${PV}_linux.tar.gz"

DESCRIPTION="Isabelle is a generic proof assistant."
HOMEPAGE="https://isabelle.in.tum.de/"

LICENSE="BSD3"

IUSE=""

DEPEND=""

S="${WORKDIR}/Isabelle${PV}"

src_install() {
	local dir="/opt/${PN}"

	# I'm doing manually instead of `doins` to preserve modes
	mkdir -p "${D}/${dir}"
	cp -r * "${D}/${dir}"

	for b in bin/*; do
		dosym "../..${dir}/${b}" "/usr/${b}"
	done
}
