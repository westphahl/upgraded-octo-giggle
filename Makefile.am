# Copyright (c) 2016 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ACLOCAL_AMFLAGS = -I m4

SUFFIXES =

SUBDIRS= .

DIST_SUBDIRS = ${SUBDIRS}

EXTRA_DIST= \
	    config/pandora_vc_revinfo \
	    ${top_srcdir}/m4/*m4

DISTCLEANFILES=		config/top.h

MAINTAINERCLEANFILES=
MAINTAINERCLEANFILES+= autom4te.cache

maintainer-clean-local:
	find . -type f -name '*~' -exec rm -f '{}' \;
	-rm -rf @PACKAGE@-*.rpm
	-rm -rf @PACKAGE@-*.tar.gz
	-rm -r -f autom4te.cache
	-rm -f Makefile.in
	-rm -f aclocal.m4
	-rm -f config/config.guess
	-rm -f config/config.sub
	-rm -f config/depcomp
	-rm -f config/install-sh
	-rm -f config/ltmain.sh
	-rm -f config/missing
	-rm -f config.in
	-rm -f config.log
	-rm -f config.status
	-rm -f configure
	-rm -f m4/libtool.m4
	-rm -f m4/ltoptions.m4
	-rm -f m4/ltsugar.m4
	-rm -f m4/ltversion.m4
	-rm -f m4/lt~obsolete.m4


bin_PROGRAMS = zuul-preview/zuul-preview
zuul_preview_zuul_preview_SOURCES = \
	zuul-preview/main.cc
