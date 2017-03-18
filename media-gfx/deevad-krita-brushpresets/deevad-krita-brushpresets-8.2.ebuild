# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
SRC_URI="http://www.peppercarrot.com/extras/resources/deevad-v${PV:0:1}-${PV:2:3}.bundle -> ${P}.bundle"
DESCRIPTION="Deevad's Krita Brushkit"
HOMEPAGE="http://davidrevoy.com/"
LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
S=${DISTDIR}

src_install()
{
	insinto /usr/share/krita/bundles
	doins ${P}.bundle
}
