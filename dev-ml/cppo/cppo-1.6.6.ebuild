# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit findlib

DESCRIPTION="An equivalent of the C preprocessor for OCaml programs"
HOMEPAGE="http://mjambon.com/cppo.html https://github.com/mjambon/cppo/"
SRC_URI="https://github.com/mjambon/cppo/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0/${PV}"
LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~x86"

IUSE=""

RDEPEND="
	>=dev-lang/ocaml-3.12:=
	dev-ml/ocamlbuild:="
DEPEND="${RDEPEND}
	dev-ml/dune"
