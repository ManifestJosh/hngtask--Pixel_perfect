import 'dart:convert';

import 'package:get/get.dart';

class Order {
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final DateTime date;

  Order({
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  // Optionally, you can add a method to convert Order to a Map or JSON
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'totalPrice': totalPrice,
      'items': jsonEncode(items), // Store as JSON string
    };
  }
}

class OrderController extends GetxController {
  var orderHistory = <Order>[].obs;

  void addOrder(Order order) {
    orderHistory.add(order);
  }
}
