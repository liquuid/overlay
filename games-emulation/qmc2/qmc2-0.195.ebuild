# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils games

DESCRIPTION="Frontend for MAME/MESS"
HOMEPAGE="https://qmc2.batcom-it.net/"
#SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${PV}/${P}.tar.bz2/download -> ${P}.tar.bz2"
SRC_URI="https://sourceforge.net/projects/qmc2/files/qmc2/0.195/qmc2-0.195.tar.bz2/download -> ${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="debug +arcade joystick opengl phonon tools"
RESTRICT="mirror"

RDEPEND=">=games-emulation/sdlmame-0.218[tools=]"
DEPEND="${RDEPEND}
	dev-qt/qtcore
	dev-qt/qtgui[accessibility]
	dev-qt/qtopengl
	dev-qt/qtsql[sqlite]
	dev-qt/qtsvg
	dev-qt/qttest
	dev-qt/qtwebkit
	dev-qt/qtxmlpatterns
	media-libs/libsdl
	net-misc/rsync
	sys-libs/zlib
	x11-apps/xwininfo
	arcade? ( dev-qt/qtdeclarative )
	joystick? ( media-libs/libsdl[joystick] )
	opengl? ( dev-qt/qtopengl )
	phonon? ( || ( media-libs/phonon dev-qt/qtphonon ) )
	tools? ( dev-qt/qtscript )"

S="${WORKDIR}/${PN}"

src_prepare() {
	# *.desktop files belong in /usr/share/applications, not /usr/share/games/applications #
	sed -e "s:\$(GLOBAL_DATADIR)/applications:${ED}usr/share/applications:g" \
		-i Makefile || die
}

src_compile() {
	FLAGS="DESTDIR=\"${ED}\" PREFIX=\"${GAMES_PREFIX}\" SYSCONFDIR=\"${GAMES_SYSCONFDIR}\" DATADIR=\"${GAMES_DATADIR}\" CTIME=0"
	emake ${FLAGS} \
		DEBUG=$(usex debug "1" "0") \
		JOYSTICK=$(usex joystick "1" "0") \
		OPENGL=$(usex opengl "1" "0") \
		PHONON=$(usex phonon "1" "0")

	use arcade && \
		emake ${FLAGS} arcade

	use tools && \
		emake ${FLAGS} tools
}

src_install() {
	emake ${FLAGS} install

	use arcade && \
		emake ${FLAGS} arcade-install

	use tools && \
		emake ${FLAGS} tools-install

	prepgamesdirs
}
