# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tweepy/tweepy-2.3.ebuild,v 1.1 2014/12/09 07:30:42 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

inherit distutils-r1

DESCRIPTION="A Python library for accessing the Twitter API "
HOMEPAGE="http://tweepy.github.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

#RESTRICT="test" 	#missing a required dep frpm portage

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/requests-2.4.3[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.3[${PYTHON_USEDEP}]
"
python_prepare_all() {
	# Required to avoid file collisions at install
	sed \
		-e "/find_packages/s:]:,'tests.*','examples']:g" \
		-i setup.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m tests || die "Tests failed"
}

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
