# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# note: files that need to be checked for dependencies etc:
# CMakeLists.txt, kexi/CMakeLists.txt kexi/migration/CMakeLists.txt
# krita/CMakeLists.txt

EAPI=5

CHECKREQS_DISK_BUILD="4G"
KDE_HANDBOOK="optional"
KDE_LINGUAS_LIVE_OVERRIDE="true"
OPENGL_REQUIRED="optional"
inherit check-reqs kde5 kde5-functions versionator

DESCRIPTION="The free drawing Appliation Krita 3"
HOMEPAGE="http://krita.org/"

case ${PV} in
	3.[456789].[789]?)
		# beta or rc releases
		SRC_URI="mirror://kde/unstable/${P}/${P}.tar.xz" ;;
	3.[456789].?)
		# stable releases
		SRC_URI="mirror://kde/stable/${P}/${P}.tar.xz" ;;
	3.[456789].9999)
		# stable branch live ebuild
		SRC_URI="" ;;
	9999)
		# master branch live ebuild
		SRC_URI="" ;;
esac

LICENSE="GPL-2"
SLOT="5"

if [[ ${KDE_BUILD_TYPE} == release ]] ; then
	KEYWORDS="~amd64 ~arm ~x86"
fi

IUSE="+attica +color-management +eigen +exif fftw +fontconfig dbus
+glew +glib +gsf gsl import-filter +jpeg jpeg2k +kdcraw kde +kdepim +lcms 
+opengl openexr +pdf spacenav sybase test +tiff +threads
+truetype +vc +xml"

RDEPEND="
	$(add_frameworks_dep kitemmodels)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kwindowsystem)
	dev-lang/perl
	dev-libs/boost
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qttest:5
	dev-qt/qtconcurrent:5
	dbus? ( dev-qt/qtdbus:5 )
	media-libs/libpng:0
	sys-libs/zlib
	virtual/libiconv
	attica? ( dev-libs/libattica )
	color-management? ( media-libs/opencolorio )
	eigen? ( dev-cpp/eigen:3 )
	exif? ( media-gfx/exiv2:= )
	fftw? ( sci-libs/fftw:3.0 )
	fontconfig? ( media-libs/fontconfig )
	gsf? ( gnome-extra/libgsf )
	gsl? ( sci-libs/gsl )
	import-filter? (
		app-text/libetonyek
		app-text/libodfgen
		app-text/libwpd:*
		app-text/libwpg:*
		app-text/libwps
		dev-libs/librevenge
		media-libs/libvisio
	)
	jpeg? ( virtual/jpeg:0 )
	jpeg2k? ( media-libs/openjpeg:0 )
	lcms? (
		media-libs/lcms:2
		x11-libs/libX11
	)
	opengl? (
		media-libs/glew
		virtual/glu
	)
	openexr? ( media-libs/openexr )
	pdf? (
		app-text/poppler:=
		media-gfx/pstoedit
	)
	spacenav? ( dev-libs/libspnav )
	tiff? ( media-libs/tiff:0 )
	truetype? ( media-libs/freetype:2 )
	vc? ( <=dev-libs/vc-0.7.4 )
	x11-libs/libX11
	x11-libs/libXi
"
DEPEND="${RDEPEND}
	x11-misc/shared-mime-info
"

# bug 394273
RESTRICT=test

pkg_pretend() {
	check-reqs_pkg_pretend
}

pkg_setup() {
	kde5_pkg_setup
	check-reqs_pkg_setup
}


src_configure() {
	local mycmakeargs=( -DPRODUCTSET="${myproducts[*]}" )

	# first write out things we want to hard-enable
	mycmakeargs+=(
		"-DGHNS=OFF"
		"-DWITH_Iconv=ON"            # available on all supported arches and many more
	)

	# default disablers
	mycmakeargs+=(
		"-DPACKAGERS_BUILD=OFF"
	)

	# regular options
	mycmakeargs+=(
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_with eigen Eigen3)
		$(cmake-utils_use_with exif Exiv2)
		$(cmake-utils_use_with fftw FFTW3)
		$(cmake-utils_use_with fontconfig Fontconfig)
		$(cmake-utils_use_with glib GLIB2)
		$(cmake-utils_use_with gsl GSL)
		$(cmake-utils_use_with import-filter LibEtonyek)
		$(cmake-utils_use_with import-filter LibOdfGen)
		$(cmake-utils_use_with import-filter LibRevenge)
		$(cmake-utils_use_with import-filter LibVisio)
		$(cmake-utils_use_with import-filter LibWpd)
		$(cmake-utils_use_with import-filter LibWpg)
		$(cmake-utils_use_with import-filter LibWps)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with jpeg2k OpenJPEG)
		$(cmake-utils_use_with kdcraw Kdcraw)
		$(cmake-utils_use_with kde KActivities)
		$(cmake-utils_use_with kdepim KdepimLibs)
		$(cmake-utils_use_with lcms LCMS2)
		$(cmake-utils_use_with openexr OpenEXR)
		$(cmake-utils_use opengl USEOPENGL)
		$(cmake-utils_use_with pdf Poppler)
		$(cmake-utils_use_with pdf Pstoedit)
		$(cmake-utils_use_with spacenav Spnav)
		$(cmake-utils_use_with tiff TIFF)
		$(cmake-utils_use_with threads Threads)
		$(cmake-utils_use_with truetype Freetype)
		$(cmake-utils_use_with vc Vc)
	)

	mycmakeargs+=( $(cmake-utils_use_build test cstester) )

	kde5_src_configure
}
