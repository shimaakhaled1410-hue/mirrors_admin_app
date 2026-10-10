import 'mirror_ui_model.dart';

class ProductionItemSummary {
  final String dimensions;
  final MirrorCategory category;
  final RetailSubCategory subCategory;
  final int totalQuantity;
  final List<String> relatedOrderIds;

  const ProductionItemSummary({
    required this.dimensions,
    required this.category,
    required this.subCategory,
    required this.totalQuantity,
    required this.relatedOrderIds,
  });

  String get groupKey => '${category.name}_${subCategory.name}_$dimensions';

  ProductionItemSummary copyWith({
    String? dimensions,
    MirrorCategory? category,
    RetailSubCategory? subCategory,
    int? totalQuantity,
    List<String>? relatedOrderIds,
  }) {
    return ProductionItemSummary(
      dimensions: dimensions ?? this.dimensions,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      relatedOrderIds: relatedOrderIds ?? this.relatedOrderIds,
    );
  }
}