EAPI=5

inherit eutils git-2 autotools

DESCRIPTION="An efficient theorem prover"
HOMEPAGE="http://z3.codeplex.com/"
EGIT_REPO_URI="https://git01.codeplex.com/z3"
EGIT_COMMIT="v${PV}"
KEYWORDS="amd64 x86"

SLOT="0"
IUSE=""
DEPEND="app-arch/unzip sys-devel/autoconf dev-lang/python:2.7 dev-vcs/git"
RDEPEND="${DEPEND}"

S="${WORKDIR}/z3"

src_prepare() {
	eautoconf
}

src_configure() {
	econf --host="" --with-python="$(which python2)"
	python2 scripts/mk_make.py
	# Changes for the 'make install' installation.
#	sed 's/ \// $(DESTDIR)\//' "build/Makefile" | \
#	sed 's/$(PREFIX)/$(DESTDIR)$(PREFIX)/' > "${WORKDIR}/tempMakefile"
#	mv "${WORKDIR}/tempMakefile" "build/Makefile"
}

src_compile() {
	emake --directory="build"
}

src_install() {
	# 'make install' installation.
#	emake DESTDIR="${D}" --directory="build" install

	dobin "build/z3"
}
