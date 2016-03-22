# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
SRC_URI="https://github.com/Deevad/deevad-krita-brushpresets/archive/v${PV}.tar.gz -> brushkit-v${PV}.tar.gz"
DESCRIPTION="Deevad's Krita Brushkit"
HOMEPAGE="http://davidrevoy.com/"
LICENSE="CC-0"
SLOT="0"
KEYWORDS="*"

IUSE="+krita calligra"


REQUIRED_USE="
krita? ( !calligra )
calligra? ( !krita )
"

src_unpack()
{
	echo $A
	unpack ${A}
}

src_prepare()
{
# Already in krita
	rm brushes/3_texture.png brushes/S_splats_02.gih brushes/P_Graphite_Black_Grass.gih brushes/A_fairy-dust.gih brushes/rake_textured_02.gbr brushes/A_grass-floor.gih brushes/A_Angular_church.gbr brushes/A_sparkle3.gbr brushes/3_eroded.gih brushes/A_random-vegetal2.gih brushes/3_rake.png brushes/A_craqules.gbr brushes/A_snow-pack.gih brushes/3_splat.png patterns/23-dynamic-screentone-A.png patterns/22_texture-reptile.png
}

src_install()
{
	if use calligra ; then
		into /usr/share/apps/krita
		cp -R ${S}/* "${D}usr/share/apps/krita/" || die "Install failed!"
	fi

	if use krita ; then
		into /usr/share/krita
		cp -R ${S}/* "${D}usr/share/krita/" || die "Install failed!"
	fi
}
