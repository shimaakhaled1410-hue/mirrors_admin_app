import 'package:flutter/material.dart';
import 'package:mirrors_admin_app/presentation/admin/admin_orders_view.dart';
import 'package:mirrors_admin_app/presentation/production/admin_production_view.dart';
import '../../core/utils/app_colors.dart';
import '../../l10n/app_localizations.dart';

class AdminMainShellView extends StatefulWidget {
  const AdminMainShellView({super.key});

  @override
  State<AdminMainShellView> createState() => _AdminMainShellViewState();
}

class _AdminMainShellViewState extends State<AdminMainShellView> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AdminOrdersView(),
    AdminProductionView(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: isDark
            ? AppColors.darkSurface
            : AppColors.lightSurface,
        indicatorColor: AppColors.accent.withValues(alpha: 0.18),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.accent,
            ),
            label: l10n.navOrders,
          ),
          NavigationDestination(
            icon: const Icon(Icons.precision_manufacturing_outlined),
            selectedIcon: const Icon(
              Icons.precision_manufacturing_rounded,
              color: AppColors.accent,
            ),
            label: l10n.navProduction,
          ),
        ],
      ),
    );
  }
}
