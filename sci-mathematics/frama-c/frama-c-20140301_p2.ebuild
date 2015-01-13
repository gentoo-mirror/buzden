# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils git-r3

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
EGIT_REPO_URI="https://forge.ispras.ru/git/astraver.frama-c"
EGIT_BRANCH="20140301"
EGIT_COMMIT="b42bd9eddb69353f62d31382dd7b69277722a9ce"
EGIT_MIN_CLONE_TYPE=single

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc gtk +ocamlopt"
RESTRICT="strip"

RDEPEND=">=dev-lang/ocaml-4[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.5[ocamlopt?]
		dev-ml/zarith
		sci-mathematics/ltl2ba
		sci-mathematics/alt-ergo
		gtk? ( >=x11-libs/gtksourceview-2.8
			>=gnome-base/libgnomecanvas-2.26
			>=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?] )"
DEPEND="${RDEPEND}
        >=dev-vcs/git-1.8"

src_prepare(){
	touch config_file

	eautoreconf
}

src_configure(){
	econf\
		$(use_enable gtk gui)
}

src_compile(){
	# dependencies can not be processed in parallel,
	# this is the intended behavior.
	emake -j1 depend || die "emake depend failed"
	emake all DESTDIR="/" || die "emake failed"
}

src_install(){
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc Changelog doc/README

	if use doc; then
		dodoc doc/manuals/*.pdf
	fi
}
