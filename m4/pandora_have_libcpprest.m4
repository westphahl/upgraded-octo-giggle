dnl  Copyright (C) 2019 Red Hat, Inc
dnl This file is free software; Red Hat, Inc
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.
 
dnl Provides support for finding libcpprest.
dnl LIBCPPREST_CFLAGS will be set, in addition to LIBCPPREST and LTLIBCPPREST

AC_DEFUN([_PANDORA_SEARCH_LIBCPPREST],[
  AC_REQUIRE([AC_LIB_PREFIX])

  dnl --------------------------------------------------------------------
  dnl  Check for libcpprest
  dnl --------------------------------------------------------------------

  AC_ARG_ENABLE([libcpprest],
    [AS_HELP_STRING([--disable-libcpprest],
      [Build with libcpprest support @<:@default=on@:>@])],
    [ac_enable_libcpprest="$enableval"],
    [ac_enable_libcpprest="yes"])

  AS_IF([test "x$ac_enable_libcpprest" = "xyes"],[
    AC_LANG_PUSH([C++])
    save_CXXFLAGS="${CXXFLAGS}"
    CXXFLAGS="${PTHREAD_CFLAGS} ${CXXFLAGS}"
    AC_LIB_HAVE_LINKFLAGS(cpprest,[boost_system ssl crypto],[
#include <cpprest/http_client.h>
    ],[
web::http::client::http_client client("http://example.com/");
    ])
    CXXFLAGS="${save_CXXFLAGS}"
    AC_LANG_POP()
  ],[
    ac_cv_libcpprest="no"
  ])

  AM_CONDITIONAL(HAVE_LIBCPPREST, [test "${ac_cv_libcpprest}" = "yes"])
])

AC_DEFUN([PANDORA_HAVE_LIBCPPREST],[
  AC_REQUIRE([_PANDORA_SEARCH_LIBCPPREST])
])

AC_DEFUN([PANDORA_REQUIRE_LIBCPPREST],[
  AC_REQUIRE([_PANDORA_SEARCH_LIBCPPREST])
  AS_IF([test "x${ac_cv_libcpprest}" = "xno"],
    PANDORA_MSG_ERROR([libcpprest is required for ${PACKAGE}.]))
])
