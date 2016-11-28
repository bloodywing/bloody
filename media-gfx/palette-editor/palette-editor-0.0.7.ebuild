# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit eutils distutils-r1

MY_P="color-palette"

SLOT="0"
DESCRIPTION="Python scripts to work with colors and color palettes."
HOMEPAGE="https://github.com/portnov/color-palette"
SRC_URI="https://github.com/portnov/color-palette/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

IUSE="lcms tinycss pillow scikit-learn scipy"

RDEPEND="
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	lcms? ( media-libs/lcms:* )
	scipy? ( sci-libs/scipy )
	tinycss? ( dev-python/tinycss[${PYTHON_USEDEP}] )
	pillow? ( dev-python/pillow[${PYTHON_USEDEP}] )
	scikit-learn? ( sci-libs/scikits_learn[${PYTHON_USEDEP}] )"

DEPEND="
${REPEND}
dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}-${PV}/${PN}"

python_prepare_all() {
	if ! use scipy; then
		rm bin/cluster.py
		sed -i "s/'bin\/cluster\.py',//g" setup.py
	fi
	distutils-r1_python_prepare_all
}
