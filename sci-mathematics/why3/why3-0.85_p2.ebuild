# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools eutils git-r3

DESCRIPTION="Why is a software verification platform."
HOMEPAGE="http://why3.lri.fr/"
EGIT_REPO_URI="http://forge.ispras.ru/git/astraver.why3"
EGIT_BRANCH="patched"
EGIT_COMMIT="5f14c07b79662e21b435fe10bdfca5d5b55c990c"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ide lib pvs coq isabelle hypothesis doc jessie3 comp-sess +ocamlopt"

RDEPEND=">=dev-lang/ocaml-4.02[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.2[ocamlopt?]
		dev-ml/menhir[ocamlopt?]
		dev-ml/zarith[ocamlopt?]
		comp-sess? ( dev-ml/camlzip[ocamlopt?] )
		ide? ( >=dev-ml/lablgtk-2.14.2[sourceview,ocamlopt?] )
		pvs? ( >=sci-mathematics/pvs-5.0 )
		coq? ( >=sci-mathematics/coq-8.4[ocamlopt?] )
		isabelle? ( sci-mathematics/isabelle )
		jessie3? ( >=sci-mathematics/frama-c-20140301[ocamlopt?] )"
DEPEND="${RDEPEND}
        >=dev-vcs/git-1.8"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf\
		--disable-local\
		$(use_enable ide)\
		$(use_enable jessie3 frama-c)\
		$(use_enable pvs pvs-libs)\
		$(use_enable coq coq-libs)\
		$(use_enable coq coq-tactic)\
		$(use_enable isabelle isabelle-libs)\
		$(use_enable hypothesis hypothesis-selection)\
		$(use_enable doc)
}

src_install() {
	emake install DESTDIR="${D}"
	use lib && emake install-lib DESTDIR="${D}"
}
