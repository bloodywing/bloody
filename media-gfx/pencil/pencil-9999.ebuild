# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils qmake-utils git-r3

DESCRIPTION="A Qt4 based animation and drawing program"
HOMEPAGE="http://pencil2d.github.io/"
EGIT_REPO_URI="git://github.com/pencil2d/pencil"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	dev-qt/qtxmlpatterns:5
"
DEPEND="${RDEPEND}
"

src_configure() {
	eqmake5 "${PN}.pro"
}

src_install() {
	# install target not yet provided
	#emake INSTALL_ROOT="${D}" install || die "emake install failed"
	newbin app/Pencil2D ${PN} || die "dobin failed"

	mv "${S}"/icons/icon.png "${S}"/icons/${PN}.png
	doicon "${S}"/icons/${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} Pencil ${PN} Graphics
}
