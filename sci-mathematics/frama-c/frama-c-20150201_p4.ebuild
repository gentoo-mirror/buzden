# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils git-r3

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
EGIT_REPO_URI="https://forge.ispras.ru/git/astraver.frama-c"
EGIT_BRANCH="20150201"
EGIT_COMMIT="8f6698c8a78f8fb37abf11ef22f4654f0a47c800"
EGIT_MIN_CLONE_TYPE=single

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc gtk +ocamlopt"
RESTRICT="strip"

RDEPEND=">=dev-lang/ocaml-4.02[ocamlopt?]
		dev-ml/camlp4[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.5[ocamlopt?]
		dev-ml/zarith[ocamlopt?]
		gtk? ( >=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?] )"
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
