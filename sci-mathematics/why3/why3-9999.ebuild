# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils git-2

DESCRIPTION="Why is a software verification platform."
HOMEPAGE="http://why3.lri.fr/"
EGIT_REPO_URI="git://scm.gforge.inria.fr/why3/why3.git"
EGIT_COMMIT="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+why2 ide pvs coq hypothesis doc"

S="${WORKDIR}/why3"

DEPEND=">=dev-lang/ocaml-3.09
		>=dev-ml/ocamlgraph-1.2
		why2? ( >=sci-mathematics/why-2.32 )
		ide? ( >=dev-ml/lablgtk-2.14[sourceview] )
		pvs? ( >=sci-mathematics/pvs-5.0 )
		coq? ( sci-mathematics/coq )"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoconf
}

src_configure() {
	econf\
		--disable-local\
		$(use_enable ide)\
		$(use_enable pvs pvs-libs)\
		$(use_enable coq coq-libs)\
		$(use_enable coq coq-tactic)\
		$(use_enable hypothesis hypothesis-selection)\
		$(use_enable doc)
	sed -e 's:OCAMLLIB *= *:OCAMLLIB = $(DESTDIR):g' -i Makefile
	sed -e 's:OCAMLINSTALLLIB *= *:OCAMLINSTALLLIB = $(DESTDIR):g' -i Makefile
}
