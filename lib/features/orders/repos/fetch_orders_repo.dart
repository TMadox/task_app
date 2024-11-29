import 'package:flutter/services.dart';
import 'package:task_app/core/resources/resources.dart';
import 'package:task_app/features/orders/models/order.dart';

class FetchOrdersRepo {
  Future<List<Order>> fetchOrders() async => await Future.delayed(
        const Duration(seconds: 1),
        () async {
          final String response = await rootBundle.loadString(JsonAssets.orders);
          return orderFromMap(response);
        },
      );
}
