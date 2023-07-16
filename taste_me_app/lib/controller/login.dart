import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taste_me_app/constants/constants.dart';

class LoginController {
  login(data) async {
    const url = "$api_route/api/auth/token/login";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );
    return response;
  }
}
