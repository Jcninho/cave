import 'package:flutter/foundation.dart';

@immutable
class ProductEntity {
  final int? id;
  final String name;
  final String? imagePath;
  final int categoryId;
  final bool isActive;
  final DateTime addedAt;

  const ProductEntity({
    this.id,
    this.imagePath,
    required this.name,
    required this.categoryId,
    required this.isActive,
    required this.addedAt,
  }) : assert(name != '', 'Product name cannot be empty');

  ProductEntity copyWith({
    int? id,
    String? name,
    String? imagePath,
    int? categoryId,
    bool? isActive,
    DateTime? addedAt,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      categoryId: categoryId ?? this.categoryId,
      isActive: isActive ?? this.isActive,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductEntity &&
        other.id == id &&
        other.name == name &&
        other.imagePath == imagePath &&
        other.categoryId == categoryId &&
        other.isActive == isActive &&
        other.addedAt == addedAt;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, imagePath, categoryId, isActive, addedAt);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, imagePath: $imagePath, categoryId: $categoryId, isActive: $isActive, addedAt: $addedAt)';
  }
}
