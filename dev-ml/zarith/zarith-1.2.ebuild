# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The Zarith library implements arithmetic and logical operations over arbitrary-precision integers"
HOMEPAGE="http://forge.ocamlcore.org/projects/zarith"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1187/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+ocamlopt"

DEPEND="
	>=dev-lang/ocaml-3.12.1[ocamlopt?]
	dev-libs/gmp"
RDEPEND="${DEPEND}"

pkg_setup() {
	OCAMLDIR=$(ocamlc -where)
}

src_prepare(){
	sed \
		-e "s:(OCAMLFIND) install:(OCAMLFIND) install -ldconf \$(INSTALLDIR)/ld.conf:g" \
		-i "${S}"/project.mak || die
	
	sed -e 's/dllzarith.dll/dllzarith.$(DLLSUFFIX)/g' -i project.mak || die
}

src_configure(){
	./configure -installdir "${D}${OCAMLDIR}" || die
	sed -e "s/-Wl,-O1 -Wl,--as-needed //g" -i Makefile || die
}

src_install(){
	dodir "${OCAMLDIR}"
	cp "${OCAMLDIR}/ld.conf" "${D}${OCAMLDIR}/ld.conf" || die
	emake install
	rm "${D}${OCAMLDIR}/ld.conf" || die
	dodoc Changes README
}
