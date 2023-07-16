import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:taste_me_app/constants/constants.dart';
import 'package:taste_me_app/models/payment.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class PaymentController {
  static Future<List<PaymentModel>> fetchPaymentMode() async {
    try {
      var authTokenBox = await Hive.openBox('authTokenBox');
      var authToken = authTokenBox.get('authToken');
      const url = "$api_route/api/mode/";
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Authorization': 'Token $authToken',
      });
      final body = response.body;
      final json = jsonDecode(body);
      final results = json["mode"] as List<dynamic>;
      final modes = results.map((e) {
        return PaymentModel(paymentId: e['id'], paymentName: e['payment_mode']);
      }).toList();
      return modes;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching payment: $e");
      }
      rethrow;
    }
  }
}
