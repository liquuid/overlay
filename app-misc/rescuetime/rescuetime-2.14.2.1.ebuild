# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="RescueTime builds a record of the activities and websites"
HOMEPAGE="https://www.rescuetime.com/"
SRC_URI="https://www.rescuetime.com/installers/rescuetime_current_amd64.deb"

inherit unpacker

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/bzip2
	app-arch/lz4
	app-arch/xz-utils
	dev-libs/double-conversion
	dev-libs/glib
	dev-libs/icu
	dev-libs/libbsd
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libpcre2
	dev-libs/libpcre
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	media-gfx/graphite2
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libpng
	sys-apps/systemd
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXScrnSaver
	x11-libs/libXtst"

BDEPEND=""

src_unpack(){
	mkdir "${S}"
	cd "${S}"
	unpacker
}


src_install(){
	cp -pR * "${D}"/
}

