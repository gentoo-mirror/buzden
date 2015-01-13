# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils git-r3

DESCRIPTION="Software verification platform"
HOMEPAGE="http://why.lri.fr/"
EGIT_REPO_URI="http://forge.ispras.ru/git/astraver.jessie2"
EGIT_BRANCH="alpha0"
EGIT_COMMIT="70fce99db41ff33beaa39963c5b7edd5b0f59c4a"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apron doc examples gtk +jessie -compat"

RDEPEND="
	>=dev-lang/ocaml-4.01
	compat? ( <dev-lang/ocaml-4.02 )
	!compat? ( >=dev-lang/ocaml-4.02 )
	>=dev-ml/ocamlgraph-1.2
	gtk? ( >=dev-ml/lablgtk-2.14 )
	apron? ( sci-mathematics/apron[ocaml] )
	jessie? ( =sci-mathematics/frama-c-20140301_p2 >=sci-mathematics/why3-0.85 )"
DEPEND="${RDEPEND}
       >=dev-vcs/git-1.8"

MAKEOPTS+=" -j1"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	$(use compat) && epatch ${FILESDIR}/2.34_p2/ocaml-4-backward-compatibility.patch
	epatch ${FILESDIR}/2.34_p2/new-bw-ax.patch
	epatch ${FILESDIR}/2.34_p2/order-fix.patch
	epatch ${FILESDIR}/2.34_p2/diverges_clause.patch
	epatch ${FILESDIR}/2.34_p2/assigns.patch
	epatch ${FILESDIR}/2.34_p2/ref_bug_fix.patch
	epatch ${FILESDIR}/2.34_p2/no-diverges-for-rec-functions.patch

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
