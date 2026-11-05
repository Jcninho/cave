import 'package:cave/core/database/app_database.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:drift/drift.dart';

/// Maps Drift Data Class ([ProductCategoryRow]) to Domain Entity ([ProductCategoryEntity]).
extension ProductCategoryRowMapper on ProductCategoryRow {
  /// Converts database row model to domain entity.
  ProductCategoryEntity toDomain() => ProductCategoryEntity(
    id: id,
    name: name,
    imageUrl: imageUrl,
    isActive: isActive,
  );
}

/// Convenience extension for batch mapping collections of [ProductCategoryRow].
extension ProductCategoryRowListMapper on Iterable<ProductCategoryRow> {
  /// Converts an iterable of database rows to a list of domain entities.
  List<ProductCategoryEntity> toDomainList() =>
      map((row) => row.toDomain()).toList();
}

/// Maps Domain Entity ([ProductCategoryEntity]) to Drift Companion ([ProductCategoriesCompanion]).
extension ProductCategoryEntityToCompanionMapper on ProductCategoryEntity {
  /// Converts domain entity to database companion for inserts/updates.
  ProductCategoriesCompanion toCompanion() {
    return ProductCategoriesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      imageUrl: Value(imageUrl),
      isActive: Value(isActive),
    );
  }
}
