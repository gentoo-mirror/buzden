# Copyright 2020 Denis Buzdalov
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

if [[ ${PV} != 9999* ]] ; then
	SRC_URI="https://github.com/cisco/ChezScheme/releases/download/v${PV}/csv${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/csv${PV}
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cisco/ChezScheme/"
fi

SLOT="0"

DESCRIPTION="Chez Scheme programming language and implementation"
HOMEPAGE="https://cisco.github.io/ChezScheme/"
LICENSE="Apache 2.0"

PATCHES=(
	"${FILESDIR}"/chezscheme-9.5.4-tinfo.patch
)

src_prepare() {
	default
	rm -r README*
}

src_configure() {
	./configure \
		--64 \
		--machine=a6le \
		--threads \
		--installprefix=/usr \
		--installlib=/usr/lib64 \
		--installbin=/usr/bin \
		--installman=/usr/share/man \
		--temproot=${D}
	# TODO to pass nice prefix, man and lib parameters
	# TODO to make `threads` to be a USE-flag
}
