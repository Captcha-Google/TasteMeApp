import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:taste_me_app/constants/constants.dart';
import 'package:taste_me_app/models/profile.dart';

class ProfileController {
  Future<ProfileModel?> fetchProfileInfo() async {
    try {
      var authTokenBox = await Hive.openBox('authTokenBox');
      var authToken = authTokenBox.get('authToken');
      const url = "$api_route/api/auth/users/me/";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Token $authToken',
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final profileData = ProfileModel(
          profileId: json["id"],
          profileUsername: json["username"] ?? "",
          profileFullname: json["first_name"] + " " + json['last_name'] ?? "",
          profileFirstName: json["first_name"] ?? "",
          profileLastName: json["last_name"] ?? "",
          profileEmail: json["email"] ?? "",
          profileIsStaff: json["is_staff"] ?? "",
          profileIsActive: json["is_active"] ?? "",
          profileDateJoined: json["date_joined"] ?? "",
          profileLastLogin: json["last_login"] ?? "",
        );
        return profileData;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching profile data: $e");
      }
      rethrow;
    }
  }
}
