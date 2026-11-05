// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductCategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductCategoriesTable get productCategories =>
      attachedDatabase.productCategories;
  ProductCategoryDaoManager get managers => ProductCategoryDaoManager(this);
}

class ProductCategoryDaoManager {
  final _$ProductCategoryDaoMixin _db;
  ProductCategoryDaoManager(this._db);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(
        _db.attachedDatabase,
        _db.productCategories,
      );
}
