inherit eutils
DESCRIPTION="An RSL typechecker"
HOMEPAGE="http://www.iist.unu.edu/newrh/III/3/1/docs/rsltc/linux/"
SRC_URI="${HOMEPAGE}/rsltc.gz"
KEYWORDS="amd64 x86"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

# TODO to learn and add dependencies.

src_install() {
	dobin ${WORKDIR}/rsltc
}
