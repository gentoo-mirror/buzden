EAPI=5

inherit eutils git-r3 autotools

DESCRIPTION="An efficient theorem prover"
HOMEPAGE="https://github.com/Z3Prover/z3"
EGIT_REPO_URI="https://github.com/Z3Prover/z3"
EGIT_COMMIT="z3-${PV}"
EGIT_MIN_CLONE_TYPE=single
KEYWORDS="amd64 x86"

SLOT="0"
LICENSE="MIT"
IUSE=""
DEPEND="app-arch/unzip sys-devel/autoconf dev-lang/python:2.7 >=dev-vcs/git-1.8"
RDEPEND=""

src_configure() {
	python2 scripts/mk_make.py
}

src_compile() {
	emake --directory="build"
}

src_install() {
	dobin "build/z3"
}
