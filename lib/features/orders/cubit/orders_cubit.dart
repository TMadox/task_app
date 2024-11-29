import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/orders/models/order.dart';
import 'package:task_app/features/orders/models/order_line_data.dart';
import 'package:task_app/features/orders/repos/fetch_orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  static OrdersCubit of(BuildContext context) => context.read<OrdersCubit>();
  Future<void> fetchOrders() async {
    emit(OrdersLoading());
    try {
      final List<Order> orders = await FetchOrdersRepo().fetchOrders();
      final int totalCount = orders.length;
      // Calculate total price and number of returns
      double totalPrice = 0.0;
      int returnCount = 0;
      for (var order in orders) {
        // Remove the dollar sign and parse the price to a double
        final double price = double.parse(order.price.replaceAll(RegExp(r'[^0-9.]'), ''));
        totalPrice += price;
        // Check if the order is returned
        if (order.status == Status.RETURNED) {
          returnCount++;
        }
      }
      // Calculate average price
      final double averagePrice = totalPrice / totalCount;
      emit(
        OrdersLoaded(
          orders: orders,
          totalCount: totalCount,
          returnedCount: returnCount,
          avgPrice: averagePrice,
        ),
      );
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  void getOrderLineData({
    required DateTime start,
    required DateTime end,
  }) {
    // Generate months within the range
    final List<DateTime> months = generateMonths(start, end);
    final Map<String, List> groupedOrders = {};
    for (var order in (state as OrdersLoaded).orders) {
      final DateTime date = order.registered;
      final String key = '${date.year}-${date.month}';
      groupedOrders.putIfAbsent(key, () => []).add(order);
    }
    // Map months to OrderLineData
    List<OrderLineData> lineData = months.map((monthDate) {
      final String key = '${monthDate.year}-${monthDate.month}';
      final int orderCount = groupedOrders[key]?.length ?? 0;
      return OrderLineData(
        date: monthDate,
        orderCount: orderCount,
      );
    }).toList();
    emit((state as OrdersLoaded).copyWith(ordersLineData: lineData));
  }

  List<DateTime> generateMonths(DateTime start, DateTime end) {
    List<DateTime> months = [];
    DateTime current = DateTime(start.year, start.month);
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      months.add(current);
      current = DateTime(current.year, current.month + 1);
    }
    // Ensure at least the start date is included if the range is very short.
    if (months.isEmpty) {
      months.add(DateTime(start.year, start.month));
    }
    return months;
  }
}
