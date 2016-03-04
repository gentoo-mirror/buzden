# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils git-r3

DESCRIPTION="Software verification platform"
HOMEPAGE="http://forge.ispras.ru/projects/astraver"
EGIT_REPO_URI="https://forge.ispras.ru/git/astraver.jessie2"
EGIT_BRANCH="alpha2"
EGIT_COMMIT="29f41d5c3f199edd35aaf6f42569508ec8f71ece"
EGIT_MIN_CLONE_TYPE=single

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.02[ocamlopt?]
	=sci-mathematics/frama-c-20150201_p3[ocamlopt?]
	>=sci-mathematics/why3-0.86.1_p1"
DEPEND="${RDEPEND}
       >=dev-vcs/git-1.8"

AUTOTOOLS_IN_SOURCE_BUILD=1
