import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/whatsapp_helper.dart';
import '../../data/models/mirror_ui_model.dart';
import '../../data/models/order_ui_model.dart';
import '../../data/models/production_item_summary.dart';
import '../../data/services/orders_firestore_service.dart';
import '../../data/services/production_aggregation_service.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/admin_production_item_card.dart';

class AdminProductionView extends StatelessWidget {
  const AdminProductionView({super.key});

  static const _aggregationService = ProductionAggregationService();

  void _shareViaWhatsApp(
    BuildContext context,
    List<ProductionItemSummary> items,
    int totalUnits,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final buffer = StringBuffer();

    buffer.writeln('📋 *${l10n.productionSummaryHeader}*');
    buffer.writeln('${l10n.totalUnitsRequired}: $totalUnits');
    buffer.writeln('----------------------');

    for (final item in items) {
      final typeLabel = item.subCategory == RetailSubCategory.withShelf
          ? l10n.filterWithShelf
          : (item.category == MirrorCategory.framed
              ? l10n.framedMirrors
              : l10n.adhesiveMirrors);

      buffer.writeln(
        '• ${item.dimensions} ${l10n.cm} ($typeLabel): *${item.totalQuantity}*',
      );
    }

    WhatsAppHelper.openWhatsApp(
      '',
      context: context,
      customMessage: buffer.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.productionTitle),
        centerTitle: true,
      ),
      body: StreamBuilder<List<OrderUiModel>>(
        stream: OrdersFirestoreService().getAllOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          final orders = snapshot.data ?? [];
          final summaryItems =
              _aggregationService.aggregateProductionItems(orders);
          final totalUnits =
              _aggregationService.calculateTotalUnits(summaryItems);
          final activeOrdersCount =
              _aggregationService.countActiveProductionOrders(orders);

          if (summaryItems.isEmpty) {
            return Center(
              child: Text(
                l10n.noProductionOrders,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.totalUnitsRequired,
                            style: AppStyles.regular12(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$totalUnits',
                            style: AppStyles.bold18(context).copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurface
                            : AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.activeProductionOrders,
                            style: AppStyles.regular12(context),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$activeOrdersCount',
                            style: AppStyles.bold18(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () =>
                    _shareViaWhatsApp(context, summaryItems, totalUnits),
                icon: const Icon(Icons.share_rounded, size: 18),
                label: Text(l10n.shareProductionSummary),
              ),
              const SizedBox(height: 16),
              ...summaryItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AdminProductionItemCard(summary: item),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}