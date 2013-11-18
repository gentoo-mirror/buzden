# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
NAME="Fluorine"
SRC_URI="http://frama-c.com/download/${PN/-c/-c-$NAME}-${PV/_/-}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gtk +ocamlopt"
RESTRICT="strip"

DEPEND=">=dev-lang/ocaml-3.12.1[ocamlopt?]
		>=dev-ml/ocamlgraph-1.8.3[gtk?,ocamlopt?]
		dev-ml/zarith
		sci-mathematics/ltl2ba
		sci-mathematics/alt-ergo
		gtk? ( >=x11-libs/gtksourceview-2.8
			>=gnome-base/libgnomecanvas-2.26
			>=dev-ml/lablgtk-2.14[sourceview,gnomecanvas,ocamlopt?] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN/-c/-c-$NAME}-${PV/_/-}"

src_prepare(){
	rm share/libc/test.c
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
