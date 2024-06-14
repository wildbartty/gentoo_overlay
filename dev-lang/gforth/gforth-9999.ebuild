# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Git head of gforth"
HOMEPAGE="https://gforth.org/"
SRC_URI="https://git.savannah.gnu.org/git/gforth/"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="check emacs"

RDEPEND="dev-libs/ffcall
dev-libs/libltdl
emacs? (app-editors/emacs)"
DEPEND="${RDEPEND}"
BDEPEND=""

src_prepare() {
	default

	if [[ -n $LIBTOOL]]; then
		export GNU_LIBTOOL=$LIBTOOL
		ln -s "${EPREFIX}"/usr/bin/libtool libtool || die
	fi

	touch aclocal.m4 configure || die
}

src_configure() {
	econf\
		$(use emacs || echo "--without-lispdir")\
		$(use_with check)
}

src_compile() {
	emake
}
