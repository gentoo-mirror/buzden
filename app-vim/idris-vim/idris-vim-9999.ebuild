# Copyright 1999-2018 Gentoo Authors
# Copyright 2019 Denis Buzdalov
# Distributed under the terms of the GNU General Public License v2

# This file is based on app-vim/airline::gentoo

EAPI=7

inherit vim-plugin

if [[ ${PV} != 9999* ]] ; then
	MY_PN=${PN}
	MY_P=${MY_PN}-${PV}
	SRC_URI="https://github.com/idris-hackers/idris-vim/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P} # LOOK AT THIS WHEN WORKING ON RELEASE, IT MAY BE NOT TRUE
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/idris-hackers/idris-vim.git"
fi

DESCRIPTION="Idris mode for vim"
HOMEPAGE="https://github.com/idris-hackers/idris-vim/"
#LICENSE="BSD3"
VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	default

	# remove unwanted files
	rm -r README* || die
}
