# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils

DESCRIPTION="Software verification platform"
HOMEPAGE="http://why.lri.fr/"
SRC_URI="http://why.lri.fr/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apron coq doc examples gappa gtk frama-c pff"

DEPEND="
	>=dev-lang/ocaml-3.09
	>=dev-ml/ocamlgraph-1.2
	gtk? ( >=dev-ml/lablgtk-2.14 )
	apron? ( sci-mathematics/apron[ocaml] )
	coq? ( sci-mathematics/coq )
	gappa? ( sci-mathematics/gappalib-coq )
	pff? ( sci-mathematics/pff )
	frama-c? ( >=sci-mathematics/frama-c-20140301 )"
RDEPEND="${DEPEND}"

MAKEOPTS+=" -j1"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch ${FILESDIR}/2.33/01-kornevgen.patch
	epatch ${FILESDIR}/2.33/02-kornevgen_nonnull-for-arrays.patch

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