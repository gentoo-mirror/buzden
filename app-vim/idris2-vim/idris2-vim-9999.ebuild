# Copyright 1999-2018 Gentoo Authors
# Copyright 2019-2020 Denis Buzdalov
# Distributed under the terms of the GNU General Public License v2

# This file is based on app-vim/vim-idris::buzden

EAPI=7

inherit vim-plugin

if [[ ${PV} != 9999* ]] ; then
	MY_PN=${PN}
	MY_P=${MY_PN}-${PV}
	SRC_URI="https://github.com/edwinb/idris2-vim/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P} # LOOK AT THIS WHEN WORKING ON RELEASE, IT MAY BE NOT TRUE
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/edwinb/idris2-vim.git"
fi

DESCRIPTION="Vim mode for Idris 2"
HOMEPAGE="https://github.com/edwinb/idris2-vim/"
#LICENSE="BSD3"
VIM_PLUGIN_HELPFILES="${PN}.txt"

PATCHES=(
#	"${FILESDIR}/${PN}-pr16.patch"
)

src_prepare() {
	default

	# remove unwanted files
	rm -r README* || die
	rm */lidris.vim
}
