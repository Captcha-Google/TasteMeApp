import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taste_me_app/constants/constants.dart';
import 'package:taste_me_app/models/table.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class TableController {
  static Future<List<TableModel>> fetchTable() async {
    try {
      var authTokenBox = await Hive.openBox('authTokenBox');
      var authToken = authTokenBox.get('authToken');
      const url = "$api_route/api/table/";
      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Token $authToken',
        },
      );
      final body = response.body;
      final json = jsonDecode(body);
      final results = json["table"] as List<dynamic>;
      final meal = results.map((e) {
        return TableModel(
          id: e['id'],
          tableName: e['table_name'],
          tabelStatus: e['table_status'],
        );
      }).toList();
      return meal;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching tables: $e");
      }
      rethrow;
    }
  }
}
