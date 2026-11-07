class ProductUnitEntity {
  final int? id;
  final int productId;
  final String name;
  final int conversionFactor;
  final double sellingPrice;
  final bool isSellable;
  final bool isPurchasable;

  const ProductUnitEntity({
    this.id,
    required this.productId,
    required this.name,
    required this.conversionFactor,
    required this.sellingPrice,
    required this.isSellable,
    required this.isPurchasable,
  });
}
