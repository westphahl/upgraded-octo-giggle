#!/bin/bash
# Copyright (c) 2017 Red Hat, Inc.
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

apt-get update
apt-get install debian-archive-keyring curl gnupg apt-transport-https
curl -L https://packagecloud.io/mrtazz/restclient-cpp/gpgkey | apt-key add -
cat > /etc/apt/sources.list.d/mrtazz_restclient-cpp.list <<EOF
deb https://packagecloud.io/mrtazz/restclient-cpp/debian/ buster main
deb-src https://packagecloud.io/mrtazz/restclient-cpp/debian/ buster main
EOF
apt-get update
apt-get install restclient-cpp

autoreconf -fi
