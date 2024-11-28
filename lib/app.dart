import 'package:flutter/material.dart';
import 'package:task_app/core/utils/routing_utils.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      routerConfig: RoutingUtils.router,
    );
  }
}
