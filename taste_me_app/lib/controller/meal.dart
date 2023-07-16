import 'package:flutter/foundation.dart';
import 'package:taste_me_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taste_me_app/models/dish.dart';
import 'package:hive/hive.dart';

class MealController {
  static Future<List<DishModel>> fetchDish() async {
    var authTokenBox = await Hive.openBox('authTokenBox');
    var authToken = authTokenBox.get('authToken');

    if (!authTokenBox.containsKey('authToken')) {
      return [];
    }

    try {
      const url = "$api_route/api/menu/";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Token $authToken',
      });
      final body = response.body;
      final json = jsonDecode(body);
      final results = json["meal"] as List<dynamic>;
      final meal = results.map((e) {
        final cusine = Cusine(cusineName: e['cusine']['cusine_name']);
        final type = DishType(dishType: e['dish_type']['dish_typename']);
        return DishModel(
            id: e['dish_id'],
            cusineName: cusine,
            dishName: e['dish_name'],
            dishImage: e['dish_image'],
            type: type,
            dishDescription: e['dish_description'],
            dishPrice: e['dish_price'],
            dishDateCreated: e['date_added']);
      }).toList();
      return meal;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching meals: $e");
      }
      rethrow;
    }
  }
}
