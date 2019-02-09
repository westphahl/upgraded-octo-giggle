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
#include <cpprest/http_client.h>

using namespace std;

int main(int, char**)
{
  web::http::client::http_client client("https://zuul.opendev.org");
  auto response = client.request(
    web::http::methods::GET,
     "/api/tenant/openstack/build/75031cad206c4014ad7a3387091d15ab").get();
  // body is a web::json::value
  auto body = response.extract_json().get();
  cout << response.status_code() << endl;
  cout << body.serialize() << endl;
  // body["log_url"] returns a web::json::value
  cout << "The log url is " << body["log_url"] << endl;
  // body["log_url"].as_string() returns a const std::string&
  cout << "The log url is " << body["log_url"].as_string() << endl;
  // body.at("log_url").as_string() returns a const std::string&
  cout << "The log url is " << body.at("log_url").as_string() << endl;
}
