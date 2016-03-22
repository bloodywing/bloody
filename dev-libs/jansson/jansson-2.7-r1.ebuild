# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
AUTOTOOLS_AUTORECONF=1

inherit autotools-multilib

DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
HOMEPAGE="http://www.digip.org/jansson/"
SRC_URI="http://www.digip.org/jansson/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="doc static-libs"

DEPEND="doc? ( >=dev-python/sphinx-1.0.4 )"
RDEPEND=""

DOCS=(CHANGES README.rst)

src_prepare() {
	sed -ie 's/-Werror//' src/Makefile.am || die
	autotools-multilib_src_prepare
}

src_compile() {
	autotools-multilib_src_compile

	use doc && autotools-multilib_src_compile html
}

src_install() {
	use doc && HTML_DOCS=("${AUTOTOOLS_BUILD_DIR}/doc/_build/html/")
	autotools-multilib_src_install
}
