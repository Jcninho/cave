class Product {
  final int? id;
  final int categoryId;
  final String name;
  final String? imageUrl;
  final bool isAvailable;
  final bool isActive;


  const Product({
     this.id,
    required this.categoryId,
    required this.name,
    required this.imageUrl,
    required this.isAvailable,
   required this.isActive,
  });
}
