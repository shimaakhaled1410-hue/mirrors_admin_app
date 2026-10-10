import 'package:mirrors_admin_app/data/models/mirror_ui_model.dart';

import '../models/order_ui_model.dart';
import '../models/production_item_summary.dart';

class ProductionAggregationService {
  const ProductionAggregationService();

  List<ProductionItemSummary> aggregateProductionItems(
    List<OrderUiModel> allOrders,
  ) {
    final Map<String, _MutableItemSummary> buffer = {};

    for (final order in allOrders) {
      if (order.status != OrderStatus.depositConfirmed &&
          order.status != OrderStatus.preparing) {
        continue;
      }

      for (final item in order.items) {
        final product = item.product;
        final key =
            '${product.category.name}_${product.subCategory.name}_${product.dimensions}';

        final existing = buffer[key];
        if (existing != null) {
          existing.totalQuantity += item.quantity;
          existing.orderIds.add(order.orderId);
        } else {
          buffer[key] = _MutableItemSummary(
            dimensions: product.dimensions,
            category: product.category,
            subCategory: product.subCategory,
            totalQuantity: item.quantity,
            orderIds: {order.orderId},
          );
        }
      }
    }

    final result = buffer.values
        .map((item) {
          return ProductionItemSummary(
            dimensions: item.dimensions,
            category: item.category,
            subCategory: item.subCategory,
            totalQuantity: item.totalQuantity,
            relatedOrderIds: item.orderIds.toList(growable: false),
          );
        })
        .toList(growable: false);

    result.sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity));
    return result;
  }

  int calculateTotalUnits(List<ProductionItemSummary> summaries) {
    var sum = 0;
    for (final item in summaries) {
      sum += item.totalQuantity;
    }
    return sum;
  }

  int countActiveProductionOrders(List<OrderUiModel> allOrders) {
    var count = 0;
    for (final order in allOrders) {
      if (order.status == OrderStatus.depositConfirmed ||
          order.status == OrderStatus.preparing) {
        count++;
      }
    }
    return count;
  }
}

class _MutableItemSummary {
  final String dimensions;
  final MirrorCategory category;
  final RetailSubCategory subCategory;
  int totalQuantity;
  final Set<String> orderIds;

  _MutableItemSummary({
    required this.dimensions,
    required this.category,
    required this.subCategory,
    required this.totalQuantity,
    required this.orderIds,
  });
}
