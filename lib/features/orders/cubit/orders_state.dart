part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<Order> orders;
  final List<OrderLineData> ordersLineData;
  final num totalCount;
  final num returnedCount;
  final num avgPrice;
  OrdersLoaded({
    this.ordersLineData = const [],
    required this.orders,
    required this.totalCount,
    required this.returnedCount,
    required this.avgPrice,
  });
  
  OrdersLoaded copyWith({
    List<Order>? orders,
    List<OrderLineData>? ordersLineData,
    num? totalCount,
    num? returnedCount,
    num? avgPrice,
  }) {
    return OrdersLoaded(
      orders: orders ?? this.orders,
      ordersLineData: ordersLineData ?? this.ordersLineData,
      totalCount: totalCount ?? this.totalCount,
      returnedCount: returnedCount ?? this.returnedCount,
      avgPrice: avgPrice ?? this.avgPrice,
    );
  }
}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}
