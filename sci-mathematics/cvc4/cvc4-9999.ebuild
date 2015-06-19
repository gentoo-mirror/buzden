# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/cvc3/cvc3-2.4.1.ebuild,v 1.5 2012/12/14 09:49:53 ulm Exp $

EAPI="5"

inherit elisp-common git-2

DESCRIPTION="CVC4 is an efficient open-source automatic theorem prover for Satisfiability Modulo Theories (SMT) problems"
HOMEPAGE="http://cvc4.cs.nyu.edu/web"
EGIT_REPO_URI="https://github.com/CVC4/CVC4"
EGIT_COMMIT="master"

LICENSE="BSD MIT HPND"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="compat glpk"

# todo to add a useflags and dependencies for GMP and CLN; they should be alternate

RDEPEND=">=dev-libs/gmp-4.2
		dev-libs/boost
		>=dev-libs/antlr-c-3.2
		compat? (
			!sci-mathematics/cvc3
		)
		glpk? (
			sci-mathematics/glpk
		)
		app-shells/bash
		sys-devel/gcc[cxx]
		"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		--disable-assertions \
		$(use_with compat) \
		$(use_with glpk)
}
