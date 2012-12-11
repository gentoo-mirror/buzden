# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools eutils

DESCRIPTION="Why is a software verification platform."
HOMEPAGE="http://why3.lri.fr/"
SRC_URI="http://gforge.inria.fr/frs/download.php/31724/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ide pvs coq hypothesis doc"

DEPEND=">=dev-lang/ocaml-3.09
		>=dev-ml/ocamlgraph-1.2
		ide? ( >=dev-ml/lablgtk-2.14[sourceview] )
		pvs? ( >=sci-mathematics/pvs-6.0 )
		coq? ( sci-mathematics/coq )"
RDEPEND="${DEPEND}"

src_configure() {
	econf\
		--disable-local\
		$(use_enable ide)\
		$(use_enable pvs pvs-libs)\
		$(use_enable coq coq-libs)\
		$(use_enable coq coq-tactic)\
		$(use_enable hypothesis hypothesis-selection)\
		$(use_enable doc)
}
