import 'dart:convert';

import 'package:organisation_management/utils/base_api.dart';
import 'package:http/http.dart' as http;
class AuthAPI extends BaseAPI {
  Future<http.Response> register(String firstName, String lastName,String email, String phone,
      String password) async {
    var body = jsonEncode({
      'user': {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'password': password,

      }
    });

    http.Response response =
    await http.post(super.registrationPath as Uri, headers: super.headers, body: body);
    return response;
  }

  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode({'email': email, 'password': password});

    http.Response response =
    await http.post(super.loginPath as Uri, headers: super.headers, body: body);

    return response;
  }


  Future<http.Response> logout(int id, String token) async {
    var body = jsonEncode({'id': id, 'token': token});

    http.Response response = await http.post(super.logoutPath as Uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }, body: body);

    return response;
  }

  Future<http.Response> getUser(int id, String token) async {
    // var body = jsonEncode({'id': id, 'token': token});

    http.Response response = await http.get(Uri.parse(super.getUserPath + id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    return response;
  }

}