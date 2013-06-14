# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools eutils

DESCRIPTION="The KeY Project -- Integrated Deductive Software Design."
HOMEPAGE="http://www.key-project.org/"
SRC_URI="http://www.key-project.org/download/releases/2.0.0/KeY-2.0.0.tgz \
http://www.key-project.org/download/releases/2.0.0/KeY-2.0.0-src.tgz \
http://www.key-project.org/download/releases/2.0.0/KeYExtLib-2.0.0.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	run_prover_script="$S/key-2.0.0_93bb62e2794d260c5a2f08c5dfdfe44df85d638e/bin/runProver"
	key_inst_home="$D/opt/key-prover"

	mkdir -p "$key_inst_home" || die

	mkdir -p "$key_inst_home/system" || die
	cp "$S/key.jar" "$key_inst_home/system" || die

	mkdir -p "$key_inst_home/bin" || die
	sed -e 's:$KEY_HOME/system/binary/:$KEY_HOME/system/key.jar:g' -i "$run_prover_script" || die
	cp "$run_prover_script" "$key_inst_home/bin/key-prover" || die
	dodir "/usr/bin" || die
	ln -sf "/opt/key-prover/bin/key-prover" "$D/usr/bin" || die

	mkdir -p "$key_inst_home/key-ext-jars" || die
	cp "$S/KeYExtLib-2.0.0/antlr.jar" "$key_inst_home/key-ext-jars" || die
	cp "$S/KeYExtLib-2.0.0/recoderKey.jar" "$key_inst_home/key-ext-jars" || die
}
