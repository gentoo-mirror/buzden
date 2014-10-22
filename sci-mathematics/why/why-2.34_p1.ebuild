# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils git-r3

DESCRIPTION="Software verification platform"
HOMEPAGE="http://why.lri.fr/"
EGIT_REPO_URI="http://public:test@sed.ispras.ru/git/why2p"
EGIT_BRANCH="Neon-patched"
EGIT_COMMIT="4217804c12cc3fac5ae920367c7e5181e54ed372"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apron coq doc examples gappa gtk jessie pff"

RDEPEND="
	>=dev-lang/ocaml-3.09
	>=dev-ml/ocamlgraph-1.2
	gtk? ( >=dev-ml/lablgtk-2.14 )
	apron? ( sci-mathematics/apron[ocaml] )
	coq? ( sci-mathematics/coq )
	gappa? ( sci-mathematics/gappalib-coq )
	pff? ( sci-mathematics/pff )
	jessie? ( =sci-mathematics/frama-c-20140301_p1 >=sci-mathematics/why3-0.85 )"
DEPEND="${RDEPEND}
       >=dev-vcs/git-1.8"

MAKEOPTS+=" -j1"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch ${FILESDIR}/2.34/why-why3-0.85-migration.patch

	sed \
		-e "s/DESTDIR =.*//g" \
		-e "s/@COQLIB@/\$(DESTDIR)\/@COQLIB@/g" \
		-i Makefile.in || die

	#to build with apron-0.9.10
	sed \
		-e "s/pvs/sri-pvs/g" \
		-e "s/oct_caml/octMPQ_caml/g" \
		-e "s/box_caml/boxMPQ_caml/g" \
		-e "s/polka_caml/polkaMPQ_caml/g" \
		-i configure.in

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable apron)
		PATH="/usr/bin:$PATH"
	)
	autotools-utils_src_configure
}

src_compile(){
	autotools-utils_src_compile DESTDIR="/"

	sed \
		-e 's/ = \/opt\// = \$(DESTDIR)\/opt\/g' \
		-i Makefile
}

src_install(){
	use doc && DOCS=( doc/manual.ps )
	autotools-utils_src_install

	doman doc/why.1

	insinto /usr/share/doc/${PF}
	use examples && doins -r examples examples-c
}
