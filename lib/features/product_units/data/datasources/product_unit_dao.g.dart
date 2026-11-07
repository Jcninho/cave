// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_unit_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductUnitDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductCategoriesTable get productCategories =>
      attachedDatabase.productCategories;
  $ProductsTable get products => attachedDatabase.products;
  $ProductUnitsTable get productUnits => attachedDatabase.productUnits;
  ProductUnitDaoManager get managers => ProductUnitDaoManager(this);
}

class ProductUnitDaoManager {
  final _$ProductUnitDaoMixin _db;
  ProductUnitDaoManager(this._db);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.productCategories,
      );
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$ProductUnitsTableTableManager get productUnits =>
      $$ProductUnitsTableTableManager(_db.attachedDatabase, _db.productUnits);
}
