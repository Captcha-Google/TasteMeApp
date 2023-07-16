import 'package:taste_me_app/constants/constants.dart';
import 'package:taste_me_app/models/orders.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class OrderController {
  static Future<List<OrdersModel>> fetchOrders() async {
    try {
      var authTokenBox = await Hive.openBox('authTokenBox');
      var authToken = authTokenBox.get('authToken');
      const url = "$api_route/api/order/";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Token $authToken',
      });
      final body = response.body;
      final json = jsonDecode(body);
      final results = json["order"] as List<dynamic>;
      final orders = results.map((e) {
        final info = DishInfo(
            dishId: e['order_dishname']['dish_id'],
            dishImage: e['order_dishname']['dish_image'],
            dishName: e['order_dishname']['dish_name'],
            dishPrice: e['order_dishname']['dish_price']);
        final cusine =
            Cusine(cusineName: e['order_dishname']['cusine']['cusine_name']);

        final type = DishType(
            dishType: e['order_dishname']['dish_type']['dish_typename']);
        return OrdersModel(
          orderId: e['order_id'],
          dishInfo: info,
          dishCusine: cusine,
          dishType: type,
          orderQuantity: e['order_quantity'],
        );
      }).toList();
      return orders;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching meals: $e");
      }
      rethrow;
    }
  }

  addOrder(data) async {
    var authTokenBox = await Hive.openBox('authTokenBox');
    var authToken = authTokenBox.get('authToken');

    const url = "$api_route/api/order/create";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Token $authToken'
      },
    );
    return response;
  }

  checkOutOrder(data) async {
    var authTokenBox = await Hive.openBox('authTokenBox');
    var authToken = authTokenBox.get('authToken');

    const url = "$api_route/api/order/checkout";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Token $authToken'
      },
    );
    return response;
  }
}
