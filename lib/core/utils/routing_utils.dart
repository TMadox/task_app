import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/core/extensions/widgets_extension.dart';
import 'package:task_app/features/intro/pages/splash_page.dart';
import 'package:task_app/features/orders/cubit/orders_cubit.dart';
import 'package:task_app/features/orders/pages/orders_page.dart';

class RoutingUtils {
  static final GoRouter router = GoRouter(
    initialLocation: const SplashPage().routeName,
    routes: routes,
  );
  static List<GoRoute> routes = [
    GoRoute(
      name: const SplashPage().routeName,
      path: const SplashPage().routeName,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: const OrdersPage().routeName,
      path: const OrdersPage().routeName,
      builder: (context, state) => BlocProvider(
        create: (context) => OrdersCubit(),
        child: const OrdersPage(),
      ),
    ),
  ];
}
