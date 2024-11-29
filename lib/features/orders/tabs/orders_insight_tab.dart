import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task_app/core/extensions/context_extension.dart';
import 'package:task_app/core/extensions/num_extensions.dart';
import 'package:task_app/core/style/app_colors.dart';
import 'package:task_app/features/orders/models/order.dart';

class OrdersInsightTab extends StatefulWidget {
  final List<Order> orders;
  final num totalCount;
  final num returnedCount;
  final num avgPrice;
  const OrdersInsightTab({
    super.key,
    required this.orders,
    required this.totalCount,
    required this.returnedCount,
    required this.avgPrice,
  });

  @override
  State<OrdersInsightTab> createState() => _OrdersInsightTabState();
}

class _OrdersInsightTabState extends State<OrdersInsightTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: AppColors.totalCountColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Text(
                            "orders_count",
                            style: context.textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ).tr(),
                          Text(
                            widget.totalCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: AppColors.averagePriceColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Text(
                            "average_price",
                            style: context.textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ).tr(),
                          Text(
                            widget.avgPrice.toPrice,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              color: AppColors.numberOfReturnsColor,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "number_of_returns",
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ).tr(),
                    Text(
                      widget.returnedCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.space,
            Text(
              "all_orders",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.start,
            ).tr(),
            8.space,
            Expanded(
              child: AnimationLimiter(
                child: ListView.separated(
                  itemCount: widget.orders.length,
                  itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      verticalOffset: 20,
                      child: FadeInAnimation(
                        child: Card(
                          child: ListTile(
                            title: Text("${widget.orders[index].buyer} (${widget.orders[index].company})"),
                            subtitle: Row(
                              children: [
                                Text(widget.orders[index].status.name),
                                const Spacer(),
                                Text(
                                  widget.orders[index].price,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => 8.space,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
