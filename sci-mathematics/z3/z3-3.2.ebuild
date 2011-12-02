inherit eutils
DESCRIPTION="An efficient theorem prover"
HOMEPAGE="http://research.microsoft.com/en-us/um/redmond/projects/z3/"
SRC_URI="amd64? ( ${HOMEPAGE}z3-x64-3.2.tar.gz ) x86? ( ${HOMEPAGE}z3-3.2.tar.gz )"
KEYWORDS="amd64 x86"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

# TODO to install libs, headers and ocaml binding (and to add appropriate use flags).

src_install() {
	dobin ${WORKDIR}/z3/bin/z3

#	dolib.a ${WORKDIR}/z3/lib/*.a
#	dolib.so ${WORKDIR}/z3/lib/*.so
}
