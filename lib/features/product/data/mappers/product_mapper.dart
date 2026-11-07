import 'package:cave/core/database/app_database.dart';
import 'package:cave/features/product/domain/entities/product_entity.dart';
import 'package:drift/drift.dart';

/// Maps Drift Data Class ([ProductRow]) to Domain Entity ([ProductEntity]).
extension ProductRowMapper on ProductRow {
  /// Converts database row model to domain entity.
  ProductEntity toDomain() => ProductEntity(
    id: id,
    name: name,
    imagePath: imagePath,
    isActive: isActive,
    categoryId: categoryId,
    addedAt: addedAt,
  );
}

/// Convenience extension for batch mapping collections of [ProductRow].
extension ProductRowListMapper on Iterable<ProductRow> {
  /// Converts an iterable of database rows to a list of domain entities.
  List<ProductEntity> toDomainList() => map((row) => row.toDomain()).toList();
}

/// Maps Domain Entity ([ProductEntity]) to Drift Companion ([ProductsCompanion]).
extension ProductEntityToCompanionMapper on ProductEntity {
  /// Converts domain entity to database companion for inserts/updates.
  ProductsCompanion toCompanion() {
    return ProductsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      imagePath: Value(imagePath),
      isActive: Value(isActive),
    );
  }
}
