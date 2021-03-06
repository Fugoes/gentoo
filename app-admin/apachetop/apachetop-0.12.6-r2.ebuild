# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://www.webta.org/projects/apachetop"
SRC_URI="http://www.webta.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc sparc x86"
IUSE="fam pcre"

RDEPEND="
	sys-libs/ncurses:0=
	sys-libs/readline:0=
	fam? ( virtual/fam )
	pcre? ( dev-libs/libpcre )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-gcc41.patch
	"${FILESDIR}"/${P}-configure.patch
	"${FILESDIR}"/${P}-maxpathlen.patch
	"${FILESDIR}"/${P}-ac_config_header.patch
	"${FILESDIR}"/${P}-ncurses.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-logfile="${EPREFIX}"/var/log/apache2/access_log \
		--without-adns \
		$(use_with fam) \
		$(use_with pcre)
}
