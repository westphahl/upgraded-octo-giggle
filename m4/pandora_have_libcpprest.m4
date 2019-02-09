dnl  Copyright (C) 2019 Red Hat, Inc
dnl This file is free software; Red Hat, Inc
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.
 
dnl Provides support for finding libcpprest.
dnl LIBCPPREST_CFLAGS will be set, in addition to LIBCPPREST and LTLIBCPPREST

AC_DEFUN([_PANDORA_SEARCH_LIBCPPREST],[
  dnl --------------------------------------------------------------------
  dnl  Check for libcpprest
  dnl --------------------------------------------------------------------

  AC_SEARCH_LIBS([CONF_modules_unload], [crypto])
  AC_LANG_PUSH([C++])
  AX_CXX_CHECK_LIB(boost_system, [boost::system::system_category()])
  AX_CXX_CHECK_LIB(cpprest, [utility::datetime::utc_now()])
  AC_LANG_POP()
])

AC_DEFUN([PANDORA_HAVE_LIBCPPREST],[
  AC_REQUIRE([_PANDORA_SEARCH_LIBCPPREST])
])

AC_DEFUN([PANDORA_REQUIRE_LIBCPPREST],[
  AC_REQUIRE([_PANDORA_SEARCH_LIBCPPREST])
  AS_IF([test "x${ac_cv_lib_cpprest_utility__datetime__utc_now__}" = "xno"],
    PANDORA_MSG_ERROR([libcpprest is required for ${PACKAGE}.]))
])
