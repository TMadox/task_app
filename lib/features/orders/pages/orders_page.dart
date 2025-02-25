import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_manager/future_manager.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:task_app/core/extensions/context_extension.dart';
import 'package:task_app/core/extensions/num_extensions.dart';
import 'package:task_app/features/orders/cubit/orders_cubit.dart';
import 'package:task_app/features/orders/models/order.dart';
import 'package:task_app/features/orders/repos/fetch_orders_repo.dart';
import 'package:task_app/features/orders/tabs/orders_insight_tab.dart';
import 'package:task_app/features/orders/tabs/orders_stats_tab.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final FutureManager<List<Order>> ordersFutureManager = FutureManager(futureFunction: () => FetchOrdersRepo().fetchOrders());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("your_orders".tr()),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () => context.setLocale(context.locale == const Locale("en") ? const Locale("ar") : const Locale("en")),
                child: Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.deepPurple,
                    ),
                    4.space,
                    Text(
                      context.locale.languageCode == "en" ? "Ar" : "En",
                      style: context.textTheme.titleLarge!.copyWith(color: Colors.deepPurple),
                    ).tr(),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          bloc: context.read<OrdersCubit>()..fetchOrders(),
          builder: (context, bloc) {
            switch (bloc) {
              case OrdersLoading():
                return const Center(
                  child: SizedBox(
                    height: 40,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                    ),
                  ),
                );
              case OrdersError():
                return Center(
                  child: Text(
                    bloc.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                );
              case OrdersLoaded():
                return FadeIn(
                  child: RefreshIndicator(
                    onRefresh: () => context.read<OrdersCubit>().fetchOrders(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(
                                text: "orders_insight".tr(),
                              ),
                              Tab(
                                text: "orders_stats".tr(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - kToolbarHeight - kBottomNavigationBarHeight - 20,
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                // passing data through parameters to prevent coupling and for a better testing
                                OrdersInsightTab(
                                  orders: bloc.orders,
                                  totalCount: bloc.totalCount,
                                  returnedCount: bloc.returnedCount,
                                  avgPrice: bloc.avgPrice,
                                ),
                                OrdersStatsTab(orders: bloc.orders),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
