# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Alt-Ergo is an automatic theorem prover dedicated to program verification."
HOMEPAGE="http://alt-ergo.lri.fr/"
SRC_URI="http://alt-ergo.lri.fr/http/${P}.tar.gz"

inherit autotools

LICENSE="CeCILL-C"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10.2
        >=dev-ml/ocamlgraph-1.7"

RDEPEND="${DEPEND}"
