class ProductCategory {
  final int? id;
  final String name;
  final String? imageUrl;
  final bool isActive;

  const ProductCategory({
    this.id,
    this.imageUrl,
    required this.name,
    required this.isActive,
  });
}
