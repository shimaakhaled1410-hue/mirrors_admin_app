import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mirrors_admin_app/presentation/admin/admin_orders_view.dart';

abstract class AppRoutes {
  static const String main = '/';
  static const String orders = '/orders';
  static const String production = '/production';
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.main,
  routes: [
    GoRoute(
      path: AppRoutes.main,
      builder: (context, state) => const AdminOrdersView(),
    ),
    GoRoute(
      path: AppRoutes.orders,
      builder: (context, state) => const AdminOrdersView(),
    ),
    GoRoute(
      path: AppRoutes.production,
      builder: (context, state) => const AdminOrdersView(),
    ),
  ],
);