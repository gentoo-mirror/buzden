# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} pypy3 )
inherit distutils-r1

DESCRIPTION="Sphinx extension which enables syntax highlighting of inline code"
HOMEPAGE="https://sphinxcontrib-inlinesyntaxhighlight.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=""
PDEPEND="
	>=dev-python/sphinx-2.0[${PYTHON_USEDEP}]"
BDEPEND="
	test? ( ${PDEPEND} )"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
