TERMUX_PKG_HOMEPAGE=https://github.com/google/re2
TERMUX_PKG_DESCRIPTION="A regular expression library"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="2024.03.01"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/google/re2/releases/download/${TERMUX_PKG_VERSION//./-}/re2-${TERMUX_PKG_VERSION//./-}.tar.gz
TERMUX_PKG_SHA256=7b2b3aa8241eac25f674e5b5b2e23d4ac4f0a8891418a2661869f736f03f57f4
TERMUX_PKG_DEPENDS="abseil-cpp, libc++"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

termux_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=11

	local v=$(sed -E -n 's/^SONAME=([0-9]+)$/\1/p' Makefile)
	if [ "${_SOVERSION}" != "${v}" ]; then
		termux_error_exit "Error: SOVERSION guard check failed."
	fi
}
