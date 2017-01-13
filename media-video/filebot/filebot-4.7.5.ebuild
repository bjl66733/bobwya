# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit java-utils-2

DESCRIPTION="Java-based tools to rename TV shows, download subtitles, and validate checksums"
HOMEPAGE="http://filebot.sourceforge.net/"

MY_PN="FileBot"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}/${MY_PN}_${PV}/${MY_PN}_${PV}-portable.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/chromaprint
		media-libs/fontconfig
		>=virtual/jre-1.8"

S="${WORKDIR}"

pkg_pretend() {
	local system_java_vm=$(eselect --brief java-vm show system | sed -e 's/ //g' -e 's/\-8$/:8/')
	if [[ "${system_java_vm}" =~ $icedtea ]]; then
		ewarn "=${CATEGORY}/${P} is known not to work correctly with the dev-java/${system_java_vm}."
		ewarn  "This is due to the fact it does not include OpenJFX support."
		ewarn  "Downgrade to <=${CATEGORY}/${PN}-4.7 as a workaround."
	fi
}

src_install() {
	java-pkg_dojar "${MY_PN}.jar"
	exeopts -m755
	exeinto "/usr/bin"
	newexe "${FILESDIR}/${PN}.sh" "${PN}"
	insopts -m644
	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.svg"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"
}