import 'package:taste_me_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class LogoutController {
  logout() async {
    var authTokenBox = await Hive.openBox('authTokenBox');
    var authToken = authTokenBox.get('authToken');

    var data = {
      "auth_token": authToken,
    };

    const url = "$api_route/api/auth/token/logout";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Authorization': 'Token $authToken',
      },
    );
    return response;
  }
}
