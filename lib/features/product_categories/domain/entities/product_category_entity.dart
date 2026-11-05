import 'package:flutter/foundation.dart';

@immutable
class ProductCategory {
  final int? id;
  final String name;
  final String? imageUrl;
  final bool isActive;

  const ProductCategory({
    this.id,
    required this.name,
    this.imageUrl,
    this.isActive = true,
  }) : assert(name != '', 'Product category name cannot be empty');

  /// Creates a copy of this [ProductCategory] with updated fields.
  ProductCategory copyWith({
    int? id,
    String? name,
    String? imageUrl,
    bool? isActive,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCategory &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.isActive == isActive;
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl, isActive);

  @override
  String toString() {
    return 'ProductCategory(id: $id, name: $name, imageUrl: $imageUrl, isActive: $isActive)';
  }
}
