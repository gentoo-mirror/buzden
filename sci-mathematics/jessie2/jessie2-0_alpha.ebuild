# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils git-r3

DESCRIPTION="Software verification platform"
HOMEPAGE="http://forge.ispras.ru/projects/astraver"
EGIT_REPO_URI="https://forge.ispras.ru/git/astraver.jessie2"
EGIT_BRANCH="alpha0"
EGIT_COMMIT="70fce99db41ff33beaa39963c5b7edd5b0f59c4a"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.02[ocamlopt?]
	=sci-mathematics/frama-c-20140301_p2[ocamlopt?]
	>=sci-mathematics/why3-0.85_p2"
DEPEND="${RDEPEND}
       >=dev-vcs/git-1.8"

AUTOTOOLS_IN_SOURCE_BUILD=1
