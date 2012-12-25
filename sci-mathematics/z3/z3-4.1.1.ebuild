EAPI=4

inherit eutils autotools

DESCRIPTION="An efficient theorem prover"
HOMEPAGE="http://z3.codeplex.com/"
SRC_URI="${PN}-src-${PV}.zip"
KEYWORDS="amd64 x86"

SLOT="0"
IUSE=""
DEPEND="app-arch/unzip sys-devel/autoconf"
RDEPEND="${DEPEND}"

S="${WORKDIR}/z3"

src_prepare() {
	eautoconf
}

src_install() {
	dobin "${WORKDIR}/z3/bin/external/z3"
}
