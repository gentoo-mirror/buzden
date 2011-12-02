inherit eutils
DESCRIPTION="An efficient theorem prover"
HOMEPAGE="http://research.microsoft.com/en-us/um/redmond/projects/z3/"
SRC_URI="amd64? ( ${HOMEPAGE}z3-x64-3.2.tar.gz ) x86? ( ${HOMEPAGE}z3-3.2.tar.gz )"
KEYWORDS="amd64 x86"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin bin/z3
#	dolib.a lib/*.a
#	dolib.so lib/*.so
}
