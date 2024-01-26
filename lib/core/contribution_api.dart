import 'dart:convert';

import 'package:organisation_management/models/contribution.dart';
import 'package:organisation_management/utils/base_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ContributionAPI extends BaseAPI {

  Future<http.Response> contribute(String description, double amount) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var id = _prefs.getInt('id');
    var body = jsonEncode({
        'user_id':id,
        'amount': amount,
        'description': description,

    });
    http.Response response =
    await http.post(super.contributePath as Uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: body);
    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
    return response;
  }



 Future<List<Contribution>> getContributions(int id, String token) async {
    // var body = jsonEncode({'id': id, 'token': token});
    SharedPreferences _prefs = await          SharedPreferences.getInstance();
    var token = _prefs.getString('token');

    http.Response response = await http.get(Uri.parse(super.getContributionsPath + id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    final List contribution = json.decode(response.body) as List<dynamic>;
    return  contribution.map((e) => Contribution.fromJson(e)).toList();

 }

}