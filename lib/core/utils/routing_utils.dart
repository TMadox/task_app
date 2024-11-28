import 'package:go_router/go_router.dart';
import 'package:task_app/core/extensions/widgets_extension.dart';
import 'package:task_app/features/intro/pages/splash_page.dart';

class RoutingUtils {
   static final GoRouter router = GoRouter(
    initialLocation: const SplashPage().routeName,
    routes: routes,
   
  );
  static List<GoRoute> routes = [
    GoRoute(
      path: const SplashPage().routeName,
      builder: (context, state) => const SplashPage(),
    ),
   
  ];
}