# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A set of tools for the Espruino JavaScript interpreter, including command-line"
HOMEPAGE="https://github.com/espruino/EspruinoTools"
#SRC_URI="https://registry.npmjs.org/${PN}/-/${P}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"
BDEPEND=">=net-libs/nodejs-16[npm]"

pkg_setup() {
	local myopts=(
		--audit false
		--color false
		--foreground-scripts
		--global
		--omit dev
		--prefix "${S}"/usr
		--progress false
		--verbose
	)
	npm ${myopts[@]} install "${PN}@${PV}" || die "npm install failed"
}

src_compile() {
	# Skip, nothing to compile here.
	:
}

src_install() {
	cp -r "${S}"/usr/ "${D}" || die "Bad installation process"
}

