/* -*- mode: c++; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 *  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 *  Copyright (C) 2019 Red Hat, Inc.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#include <config.h>
#include <pthread.h>
#include <json.hpp>
#include <restclient-cpp/restclient.h>

// for convenience
using json = nlohmann::json;
using namespace std;

int main(int, char**)
{

  RestClient::Response r = RestClient::get("http://zuul.opendev.org/api/tenant/openstack/build/75031cad206c4014ad7a3387091d15ab");

  json j = json::parse(r.body);

  cout << j.dump(4) << endl; 
}
