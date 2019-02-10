# Copyright (C) 2019 Red Hat, Inc
# 
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 3 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#
# As a special exception, the respective Autoconf Macro's copyright owner
# gives unlimited permission to copy, distribute and modify the configure
# scripts that are the output of Autoconf when processing the Macro. You
# need not follow the terms of the GNU General Public License when using
# or distributing such scripts, even though portions of the text of the
# Macro appear in them. The GNU General Public License (GPL) does govern
# all other use of the material that constitutes the Autoconf Macro.
#
# This special exception to the GPL applies to versions of the Autoconf
# Macro released by the Autoconf Macro's copyright owner. When you make
# and distribute a modified version of the Autoconf Macro, you may extend
# this special exception to the GPL to apply to your modified version as well.

AC_DEFUN([OPENDEV_OPTIMIZE],[
  AC_REQUIRE([AX_CODE_COVERAGE])

  AM_CPPFLAGS="-g ${AM_CPPFLAGS}"

  AS_IF([test "$enable_code_coverage" = "yes"],[
    AM_CPPFLAGS="${AM_CPPFLAGS} ${CODE_COVERAGE_CPPFLAGS}"
    AM_CFLAGS="${AM_CFLAGS} ${CODE_COVERAGE_CFLAGS}"
    AM_CXXFLAGS="${AM_CXXFLAGS} ${CODE_COVERAGE_CXXFLAGS}"
    AM_LDFLAGS="${AM_LDFLAGS} ${CODE_COVERAGE_LDFLAGS}"
  ])

  OPTIMIZE_CFLAGS="-O2"
  OPTIMIZE_CXXFLAGS="-O2"

  AS_IF([test "$enable_debug" = "no"],[
    # Optimized version. No debug
    AM_CFLAGS="${AM_CFLAGS} ${OPTIMIZE_CFLAGS}"
    AM_CXXFLAGS="${AM_CXXFLAGS} ${OPTIMIZE_CXXFLAGS}"
  ])
])
