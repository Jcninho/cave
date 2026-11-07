import 'package:cave/core/database/app_database.dart';
import 'package:cave/features/product_units/domain/entities/product_unit_entity.dart';
import 'package:drift/drift.dart';

/// Maps Drift Data Class ([ProductUnitRow]) to Domain Entity ([ProductUnitEntity]).
extension ProductUnitRowMapper on ProductUnitRow {
  /// Converts database row model to domain entity.
  ProductUnitEntity toDomain() => ProductUnitEntity(
    id: id,
    name: name,
    productId: productId,
    conversionFactor: conversionFactor,
    sellingPrice: sellingPrice,
    isSellable: isSellable,
    isPurchasable: isPurchasable,
  );
}

/// Convenience extension for batch mapping collections of [ProductUnitRow].
extension ProductUnitRowListMapper on Iterable<ProductUnitRow> {
  /// Converts an iterable of database rows to a list of domain entities.
  List<ProductUnitEntity> toDomainList() =>
      map((row) => row.toDomain()).toList();
}

/// Maps Domain Entity ([ProductUnitEntity]) to Drift Companion ([ProductUnitsCompanion]).
extension ProductUnitEntityToCompanionMapper on ProductUnitEntity {
  /// Converts domain entity to database companion for inserts/updates.
  ProductUnitsCompanion toCompanion() {
    return ProductUnitsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      productId: Value(productId),
      conversionFactor: Value(conversionFactor),
      sellingPrice: Value(sellingPrice),
      isSellable: Value(isSellable),
      isPurchasable: Value(isPurchasable),
    );
  }
}
