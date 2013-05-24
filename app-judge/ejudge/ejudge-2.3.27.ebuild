EAPI=5

inherit eutils

DESCRIPTION="Ejudge contest management system"
HOMEPAGE="http://www.ejudge.ru/"
SRC_URI="http://www.ejudge.ru/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+ajax mysql java cxx mono +submits-limitation"

RDEPEND="sys-devel/make
	sys-devel/gcc
	sys-libs/glibc
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	sys-apps/sed
	sys-libs/zlib
	sys-libs/ncurses
	dev-libs/expat
	sys-devel/gettext
	dev-libs/libzip
	mysql? ( virtual/mysql )
	net-misc/curl
	dev-libs/ossp-uuid
	virtual/httpd-cgi
	java? ( virtual/jdk )
	cxx? ( sys-devel/gcc[cxx] virtual/libstdc++ )
	mono? ( dev-lang/mono )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/ejudge"

EJUDGE_USER=ejudge
EJUDGE_GROUP=ejudge

pkg_pretend() {
	[[ -z "$EJUDGE_CONTESTS_HOME" ]] && die "Ejudge contests home is not set."
	[[ -e "$EJUDGE_CONTESTS_HOME" && ! -d "$EJUDGE_CONTESTS_HOME" ]] && \
		die "EJUDGE_CONTESTS_HOME must point to an existent or non-existent directory."
	[[ -e "$EJUDGE_CONTESTS_HOME" && -n "$(ls "$EJUDGE_CONTESTS_HOME")" ]] && \
		die "Ejudge contests home must be empty."

	[[ -z "$EJUDGE_CGI_BIN_DIR" ]] && die "Ejudge cgi-bin dir is not set."
	[[ -d "$EJUDGE_CGI_BIN_DIR" ]] || die "EJUDGE_CGI_BIN_DIR must be a directory."

	[[ -z "$EJUDGE_HTDOCS_DIR" ]] && die "Ejudge htdocs dir is not set."
	[[ -d "$EJUDGE_HTDOCS_DIR" ]] || die "EJUDGE_HTDOCS_DIR must be a directory."
}

pkg_setup() {
	enewgroup $EJUDGE_GROUP
	enewuser $EJUDGE_USER -1 "/bin/bash" $EJUDGE_CONTESTS_HOME $EJUDGE_GROUP
}

src_unpack() {
	default_src_unpack

	use submits-limitation && epatch $FILESDIR/submits-limitation-${PV}.patch

	sed "s/Cannot create a temporary directory\\n/Cannot create a temporary directory 1\\n/" \
		"$S/ejudge-setup.c" > "$T/new-ejudge-setup.c" &&\
	mv "$T/new-ejudge-setup.c" "$S/ejudge-setup.c"

	sed "s/Cannot create a temporary directory\\n/Cannot create a temporary directory 2\\n/" \
		"$S/ejudge-setup.c" > "$T/new-ejudge-setup.c" &&\
	mv "$T/new-ejudge-setup.c" "$S/ejudge-setup.c"
}

src_configure() {
	contests_home_conf="--enable-contests-home-dir=$EJUDGE_CONTESTS_HOME"
	cgi_bin_dir_conf="--with-httpd-cgi-bin-dir=$EJUDGE_CGI_BIN_DIR"
	htdocs_dir_conf="--with-httpd-htdocs-dir=$EJUDGE_HTDOCS_DIR"
	[[ -z "$EJUDGE_LOCAL_STATE_DIR" ]] \
		|| local_state_conf="--enable-local-dir=$EJUDGE_LOCAL_STATE_DIR"

	econf \
		$(use_enable ajax) \
		"$contests_home_conf" \
		"$cgi_bin_dir_conf" \
		"$htdocs_dir_conf" \
		"$local_state_conf"

	sed "s/ejudge-setup -b/ejudge-setup -b -u $EJUDGE_USER -g $EJUDGE_GROUP/g" \
		"$S/Makefile" > "$T/newMakefile" &&\
	mv "$T/newMakefile" "$S/Makefile"
}

src_install() {
	dodir "$EJUDGE_CONTESTS_HOME"
	chown -R $EJUDGE_USER:$EJUDGE_GROUP	"$D$EJUDGE_CONTESTS_HOME"

	export TEMPDIR="$T"
	default_src_install
}

# todo to make cgi-bins executable.

#pkg_config() {
	# todo
#}
