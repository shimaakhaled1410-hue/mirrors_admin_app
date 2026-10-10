import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/whatsapp_helper.dart';
import '../../data/models/order_ui_model.dart';
import '../../data/services/orders_firestore_service.dart';
import '../../l10n/app_localizations.dart';
import '../manager/app_settings/app_settings_cubit.dart';
import '../manager/app_settings/app_settings_state.dart';
import 'widgets/admin_order_card.dart';
import 'widgets/admin_order_filters_bar.dart';
import 'widgets/admin_status_sheet.dart';

class AdminOrdersView extends StatefulWidget {
  const AdminOrdersView({super.key});

  @override
  State<AdminOrdersView> createState() => _AdminOrdersViewState();
}

class _AdminOrdersViewState extends State<AdminOrdersView> {
  final OrdersFirestoreService _firestoreService = OrdersFirestoreService();
  OrderStatus? _selectedStatus;

  Map<OrderStatus?, int> _calculateCounts(List<OrderUiModel> orders) {
    final Map<OrderStatus?, int> counts = {null: orders.length};
    for (final status in OrderStatus.values) {
      counts[status] = orders.where((o) => o.status == status).length;
    }
    return counts;
  }

  void _showStatusSheet(OrderUiModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AdminStatusSheet(
        order: order,
        onStatusSelected: (newStatus) async {
          Navigator.pop(context);
          await _firestoreService.updateOrderStatus(order.orderId, newStatus);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminOrdersTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: StreamBuilder<List<OrderUiModel>>(
        stream: _firestoreService.getAllOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          final allOrders = snapshot.data ?? [];
          final counts = _calculateCounts(allOrders);
          final orders = _selectedStatus == null
              ? allOrders
              : allOrders
                  .where((order) => order.status == _selectedStatus)
                  .toList();

          return Column(
            children: [
              AdminOrderFiltersBar(
                selectedFilter: _selectedStatus,
                onFilterSelected: (status) {
                  setState(() {
                    _selectedStatus = status;
                  });
                },
                counts: counts,
              ),
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Text(
                          l10n.noOrdersYet,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: orders.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return AdminOrderCard(
                            order: order,
                            onCall: () {
                              if (order.phoneNumber != null &&
                                  order.phoneNumber!.isNotEmpty) {
                                WhatsAppHelper.launchCall(
                                  order.phoneNumber!,
                                  context: context,
                                );
                              }
                            },
                            onWhatsApp: () {
                              if (order.phoneNumber != null &&
                                  order.phoneNumber!.isNotEmpty) {
                                WhatsAppHelper.openWhatsApp(
                                  order.phoneNumber!,
                                  context: context,
                                  customMessage:
                                      'أهلاً بك يا ${order.customerName ?? 'عميلنا العزيز'} بخصوص طلبك رقم #${order.orderId}',
                                );
                              }
                            },
                            onChangeStatus: () => _showStatusSheet(order),
                            onConfirmDeposit: () async {
                              await _firestoreService.updateOrderStatus(
                                order.orderId,
                                OrderStatus.depositConfirmed,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void _showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) {
      return BlocBuilder<AppSettingsCubit, AppSettingsState>(
        builder: (context, state) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final isArabic = state.locale.languageCode == 'ar';

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(isArabic ? 'الإعدادات' : 'Settings'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: Text(
                    isArabic ? 'الوضع الداكن' : 'Dark Mode',
                  ),
                  secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                  ),
                  value: isDark,
                  onChanged: (val) {
                    context.read<AppSettingsCubit>().toggleTheme(val);
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(isArabic ? 'اللغة' : 'Language'),
                  subtitle: Text(isArabic ? 'العربية' : 'English'),
                  leading: const Icon(Icons.language),
                  trailing: DropdownButton<String>(
                    value: state.locale.languageCode,
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text('العربية'),
                      ),
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                    ],
                    onChanged: (langCode) {
                      if (langCode != null) {
                        context
                            .read<AppSettingsCubit>()
                            .changeLocale(Locale(langCode));
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(isArabic ? 'إغلاق' : 'Close'),
              ),
            ],
          );
        },
      );
    },
  );
}