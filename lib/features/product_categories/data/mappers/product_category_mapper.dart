
import 'package:cave/core/database/app_database.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';

extension ProductCategoryMapper on ProductCategoryRow {
  ProductCategoryEntity toDomain() {
    return ProductCategoryEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      isActive: isActive,
    );
  }
}
