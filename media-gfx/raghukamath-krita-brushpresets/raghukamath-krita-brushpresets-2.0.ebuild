# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
SRC_URI="https://github.com/raghukamath/krita-brush-presets/raw/v${PV}/bundles/Raghukamath-Brush-Pack.bundle -> ${P}.bundle"
DESCRIPTION="Raghukamath's Krita Brushkit"
HOMEPAGE="http://raghukamath.com"
LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
S=${DISTDIR}

src_install()
{
	insinto /usr/share/krita/bundles
	doins ${P}.bundle
}
