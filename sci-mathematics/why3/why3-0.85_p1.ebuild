# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools eutils git-r3

DESCRIPTION="Why is a software verification platform."
HOMEPAGE="http://why3.lri.fr/"
EGIT_REPO_URI="http://forge.ispras.ru/git/astraver.why3"
EGIT_BRANCH="patched"
EGIT_COMMIT="a97fa48d541d0321284732b5b2bce9bf1176afba"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+why2 ide pvs coq hypothesis doc jessie3"

RDEPEND=">=dev-lang/ocaml-4
		>=dev-ml/ocamlgraph-1.2
		dev-ml/menhir
		ide? ( >=dev-ml/lablgtk-2.14[sourceview] )
		pvs? ( >=sci-mathematics/pvs-5.0 )
		coq? ( sci-mathematics/coq )
		jessie3? ( >=sci-mathematics/frama-c-20140301 )"
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
		$(use_enable hypothesis hypothesis-selection)\
		$(use_enable doc)
}
