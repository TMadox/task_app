part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<Order> orders;
  final num totalCount;
  final num returnedCount;
  final num avgPrice;
  OrdersLoaded({
    required this.orders,
    required this.totalCount,
    required this.returnedCount,
    required this.avgPrice,
  });
}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}
