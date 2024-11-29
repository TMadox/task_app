import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_app/core/extensions/datetime_extension.dart';
import 'package:task_app/features/orders/models/order.dart';

class OrdersStatsTab extends StatelessWidget {
  final List<Order> orders;
  const OrdersStatsTab({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    List<String> orderDates = orders.map((order) => order.registered).map((date) => DateFormat('yyyy-MM-dd').format(DateTime.parse(date))).toList();
   
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          series: [
            LineSeries<Order, String>(
              dataSource: orders,
              xValueMapper: (Order spot, _) => DateFormat('yyyy-MM-dd').parse(spot.registered).ymd,
              yValueMapper: (Order spot, _) => 10,
            ),
          ],
        ),
      ),
    );
  }
}
