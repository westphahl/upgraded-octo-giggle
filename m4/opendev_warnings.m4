# Copyright (C) 2009 Sun Microsystems, Inc.
# Copyright (C) 2019 Red Hat, Inc
# This file is free software; The Autoconf Macro copyright holders
# give unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.
 
AC_DEFUN([OPENDEV_WARNINGS],[

    AC_CACHE_CHECK([whether it is safe to use -fdiagnostics-show-option],
      [ac_cv_safe_to_use_fdiagnostics_show_option_],
      [save_CFLAGS="$CFLAGS"
       CFLAGS="-fdiagnostics-show-option ${AM_CFLAGS} ${CFLAGS}"
       AC_COMPILE_IFELSE(
         [AC_LANG_PROGRAM([],[])],
         [ac_cv_safe_to_use_fdiagnostics_show_option_=yes],
         [ac_cv_safe_to_use_fdiagnostics_show_option_=no])
       CFLAGS="$save_CFLAGS"])

    AS_IF([test "$ac_cv_safe_to_use_fdiagnostics_show_option_" = "yes"],
          [F_DIAGNOSTICS_SHOW_OPTION="-fdiagnostics-show-option"])

    AC_CACHE_CHECK([whether it is safe to use -floop-parallelize-all],
      [ac_cv_safe_to_use_floop_parallelize_all_],
      [save_CFLAGS="$CFLAGS"
       CFLAGS="-floop-parallelize-all ${AM_CFLAGS} ${CFLAGS}"
       AC_COMPILE_IFELSE(
         [AC_LANG_PROGRAM([],[])],
         [ac_cv_safe_to_use_floop_parallelize_all_=yes],
         [ac_cv_safe_to_use_floop_parallelize_all_=no])
       CFLAGS="$save_CFLAGS"])

    AS_IF([test "$ac_cv_safe_to_use_floop_parallelize_all_" = "yes"],
          [F_LOOP_PARALLELIZE_ALL="-floop-parallelize-all"])

    BASE_WARNINGS="-Wextra -pedantic -Wall -Wundef -Wshadow ${F_DIAGNOSTICS_SHOW_OPTION} ${F_LOOP_PARALLELIZE_ALL} -Wstrict-aliasing -Wswitch-enum "
    CC_WARNINGS_FULL="-Wswitch-default -Wswitch-enum -Wwrite-strings"
    CXX_WARNINGS_FULL="-Weffc++ -Wold-style-cast"

    AC_CACHE_CHECK([whether it is safe to use -Wextra],[ac_cv_safe_to_use_Wextra_],[
      save_CFLAGS="$CFLAGS"
      CFLAGS="-Wextra -pedantic -Wextra ${AM_CFLAGS} ${CFLAGS}"
      AC_COMPILE_IFELSE([
        AC_LANG_PROGRAM(
          [[
#include <stdio.h>
          ]], [[]]
        )],
        [ac_cv_safe_to_use_Wextra_=yes],
        [ac_cv_safe_to_use_Wextra_=no])
      CFLAGS="$save_CFLAGS"
    ])

    AS_IF([test "$ac_cv_safe_to_use_Wextra_" = "yes"],
          [BASE_WARNINGS="${BASE_WARNINGS} -Wextra"],
          [BASE_WARNINGS="${BASE_WARNINGS} -W"])
 
    AC_CACHE_CHECK([whether it is safe to use -Wformat],[ac_cv_safe_to_use_wformat_],[
      save_CFLAGS="$CFLAGS"
      dnl Use -Werror here instead of -Wextra so that we don't spew
      dnl conversion warnings to all the tarball folks
      CFLAGS="-Wformat -Werror -pedantic ${AM_CFLAGS} ${CFLAGS}"
      AC_COMPILE_IFELSE([
        AC_LANG_PROGRAM(
          [[
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
void foo();
void foo()
{
  uint64_t test_u= 0;
  printf("This is a %" PRIu64 "test\n", test_u);
}
          ]],[[
foo();
          ]]
        )],
        [ac_cv_safe_to_use_wformat_=yes],
        [ac_cv_safe_to_use_wformat_=no])
      CFLAGS="$save_CFLAGS"])

    AS_IF([test "$ac_cv_safe_to_use_wformat_" = "yes"],
          [BASE_WARNINGS="${BASE_WARNINGS} -Wformat=2"],
          [BASE_WARNINGS="${BASE_WARNINGS} -Wno-format"])
 
    AC_CACHE_CHECK([whether it is safe to use -Wconversion],[ac_cv_safe_to_use_wconversion_],[
      save_CFLAGS="$CFLAGS"
      dnl Use -Werror here instead of -Wextra so that we don't spew
      dnl conversion warnings to all the tarball folks
      CFLAGS="-Wconversion -Werror -pedantic ${AM_CFLAGS} ${CFLAGS}"
      AC_COMPILE_IFELSE([
        AC_LANG_PROGRAM(
          [[
#include <stdbool.h>
void foo(bool a)
{
  (void)a;
}
          ]],[[
foo(0);
          ]]
        )],
        [ac_cv_safe_to_use_wconversion_=yes],
        [ac_cv_safe_to_use_wconversion_=no])
      CFLAGS="$save_CFLAGS"])
  
      AS_IF([test "$ac_cv_safe_to_use_wconversion_" = "yes"],
            [W_CONVERSION="-Wconversion"])

      CC_WARNINGS="${BASE_WARNINGS} -Wattributes -Wstrict-prototypes -Wmissing-prototypes -Wredundant-decls -Wmissing-declarations -Wcast-align ${CC_WARNINGS_FULL} ${W_CONVERSION}"
      CXX_WARNINGS="${BASE_WARNINGS} -Wattributes -Woverloaded-virtual -Wnon-virtual-dtor -Wctor-dtor-privacy ${CXX_WARNINGS_FULL} ${W_CONVERSION}"

      AC_CACHE_CHECK([whether it is safe to use -Wframe-larger-than],[ac_cv_safe_to_use_Wframe_larger_than_],[
        AC_LANG_PUSH(C++)
        save_CXXFLAGS="$CXXFLAGS"
        CXXFLAGS="-Werror -pedantic -Wframe-larger-than=32768 ${AM_CXXFLAGS}"
        AC_COMPILE_IFELSE([
          AC_LANG_PROGRAM(
            [[
#include <stdio.h>
            ]], [[]]
          )],
          [ac_cv_safe_to_use_Wframe_larger_than_=yes],
          [ac_cv_safe_to_use_Wframe_larger_than_=no])
        CXXFLAGS="$save_CXXFLAGS"
        AC_LANG_POP()
      ])

      AS_IF([test "$ac_cv_safe_to_use_Wframe_larger_than_" = "yes"],
            [CXX_WARNINGS="${CXX_WARNINGS} -Wframe-larger-than=32768"])
  
      AC_CACHE_CHECK([whether it is safe to use -Wlogical-op],[ac_cv_safe_to_use_Wlogical_op_],[
        save_CFLAGS="$CFLAGS"
        CFLAGS="-Wextra -pedantic -Wlogical-op ${AM_CFLAGS} ${CFLAGS}"
        AC_COMPILE_IFELSE([
          AC_LANG_PROGRAM(
            [[
#include <stdio.h>
            ]], [[]]
          )],
          [ac_cv_safe_to_use_Wlogical_op_=yes],
          [ac_cv_safe_to_use_Wlogical_op_=no])
        CFLAGS="$save_CFLAGS"])

      AS_IF([test "$ac_cv_safe_to_use_Wlogical_op_" = "yes"],
            [CC_WARNINGS="${CC_WARNINGS} -Wlogical-op"])
  
      AC_CACHE_CHECK([whether it is safe to use -Wredundant-decls from C++],[ac_cv_safe_to_use_Wredundant_decls_],[
        AC_LANG_PUSH(C++)
        save_CXXFLAGS="${CXXFLAGS}"
        CXXFLAGS="-Wextra -pedantic -Wredundant-decls ${AM_CXXFLAGS}"
        AC_COMPILE_IFELSE([
          AC_LANG_PROGRAM(
            [
template <typename E> struct C { void foo(); };
template <typename E> void C<E>::foo() { }
template <> void C<int>::foo();
AC_INCLUDES_DEFAULT
            ])],
          [ac_cv_safe_to_use_Wredundant_decls_=yes],
          [ac_cv_safe_to_use_Wredundant_decls_=no])
        CXXFLAGS="${save_CXXFLAGS}"
        AC_LANG_POP()])

      AS_IF([test "$ac_cv_safe_to_use_Wredundant_decls_" = "yes"],
            [CXX_WARNINGS="${CXX_WARNINGS} -Wredundant-decls"],
            [CXX_WARNINGS="${CXX_WARNINGS} -Wno-redundant-decls"])

])
