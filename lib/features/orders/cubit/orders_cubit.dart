import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_app/features/orders/models/order.dart';
import 'package:task_app/features/orders/repos/fetch_orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
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
}
