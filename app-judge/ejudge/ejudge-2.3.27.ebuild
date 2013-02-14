IAPI=4

inherit eutils

DESCRIPTION="Ejudge contest management system"
HOMEPAGE="http://www.ejudge.ru/"
SRC_URI="http://www.ejudge.ru/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ajax mysql java cxx mono"

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

src_configure() {
	[[ -z "$EJUDGE_CONTESTS_HOME" ]] \
		&& ewarn "Ejudge contests home is not set." \
		|| contests_home_conf="--enable-contests-home-dir=$EJUDGE_CONTESTS_HOME"
	[[ -z "$EJUDGE_CGI_BIN_DIR" ]] \
		&& ewarn "Ejudge cgi-bin dir is not set." \
		|| cgi_bin_dir_conf="--with-httpd-cgi-bin-dir=$EJUDGE_CGI_BIN_DIR"
	[[ -z "$EJUDGE_HTDOCS_DIR" ]] \
		&& ewarn "Ejudge htdocs dir is not set." \
		|| htdocs_dir_conf="--with-httpd-htdocs-dir=$EJUDGE_HTDOCS_DIR"
	[[ -z "$EJUDGE_LOCAL_STATE_DIR" ]] \
		|| local_state_conf="--enable-local-dir=$EJUDGE_LOCAL_STATE_DIR"

	econf \
		$(use_enable ajax) \
		"$contests_home_conf" \
		"$cgi_bin_dir_conf" \
		"$htdocs_dir_conf" \
		"$local_state_conf"
}

# todo to make cgi-bins executable.

#pkg_config() {
	# todo
#}
