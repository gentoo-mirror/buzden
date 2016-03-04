# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Alt-Ergo is an automatic theorem prover"
HOMEPAGE="http://alt-ergo.lri.fr"
SRC_URI="http://alt-ergo.ocamlpro.com/download_manager.php?target=${P}.tar.gz"

LICENSE="CeCILL-C"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt gtk satml"

DEPEND="
	>=dev-lang/ocaml-3.12.1[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.2[gtk?,ocamlopt?]
	!=dev-ml/ocamlgraph-1.8.4
    dev-ml/zarith
	gtk? (
		x11-libs/gtksourceview:2.0
		>=dev-ml/lablgtk-2.14[sourceview,ocamlopt?]
	)"
RDEPEND="${DEPEND}"

src_compile(){
	emake
	use gtk && emake gui
	use satml && emake satML
}

src_install() {
	emake DESTDIR="${D}" install
	use gtk && emake DESTDIR="${D}" install-gui
	use satml && emake DESTDIR="${D}" install-satML
}
