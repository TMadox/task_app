import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_app/core/extensions/datetime_extension.dart';
import 'package:task_app/core/extensions/num_extensions.dart';
import 'package:task_app/features/orders/cubit/orders_cubit.dart';
import 'package:task_app/features/orders/models/order.dart';
import 'package:task_app/features/orders/models/order_line_data.dart';

class OrdersStatsTab extends StatefulWidget {
  final List<Order> orders;
  const OrdersStatsTab({super.key, required this.orders});

  @override
  State<OrdersStatsTab> createState() => _OrdersStatsTabState();
}

class _OrdersStatsTabState extends State<OrdersStatsTab> with AutomaticKeepAliveClientMixin {
  @override
  void didChangeDependencies() {
    OrdersCubit.of(context).getOrderLineData(start: DateTime(2020), end: DateTime.now());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormBuilderDateRangePicker(
              name: "date",
              // locale: const Locale("en"),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(),
                hintText: "select_date_range".tr(),
                prefixIcon: const Icon(Icons.calendar_month),
              ),
              onChanged: (value) {
                if (value != null) {
                  OrdersCubit.of(context).getOrderLineData(start: value.start, end: value.end);
                }
              },
            ),
            16.space,
            Expanded(
              child: BlocSelector<OrdersCubit, OrdersState, List<OrderLineData>>(
                selector: (state) => (state as OrdersLoaded).ordersLineData,
                builder: (context, state) => SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                  ),
                  series: [
                    LineSeries<OrderLineData, String>(
                      dataSource: state,
                      xValueMapper: (OrderLineData lineData, _) => lineData.date.ymd,
                      yValueMapper: (OrderLineData lineData, _) => lineData.orderCount,
                    ),
                  ],
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
