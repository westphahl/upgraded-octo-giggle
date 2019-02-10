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
 
# Provides support for finding libcpprest.
# LIBCPPREST_CFLAGS will be set, in addition to LIBCPPREST and LTLIBCPPREST

AC_DEFUN([REQUIRE_LIBCPPREST],[
  # --------------------------------------------------------------------
  #  Check for libcpprest
  # --------------------------------------------------------------------
  AC_SEARCH_LIBS([CONF_modules_unload], [crypto])
  AC_LANG_PUSH([C++])
  AX_CXX_CHECK_LIB(boost_system, [boost::system::system_category()])
  AX_CXX_CHECK_LIB(cpprest, [utility::datetime::utc_now()])
  AC_LANG_POP()
  AS_IF([test "x${ac_cv_lib_cpprest_utility__datetime__utc_now__}" = "xno"],
    AC_MSG_ERROR([libcpprest is required for ${PACKAGE}.]))
])
