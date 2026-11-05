import 'package:cave/core/database/app_database.dart';
import 'package:cave/core/database/tables/product_categories_table.dart';
import 'package:drift/drift.dart';

part 'product_category_dao.g.dart';

@DriftAccessor(tables: [ProductCategories])
class ProductCategoryDao extends DatabaseAccessor<AppDatabase>
    with _$ProductCategoryDaoMixin {
  ProductCategoryDao(super.db);

  /// Helper base query to apply consistent ordering by category name.
  SimpleSelectStatement<$ProductCategoriesTable, ProductCategoryRow>
  _selectOrdered() {
    return select(productCategories)
      ..orderBy([(c) => OrderingTerm.asc(c.name)]);
  }

  /// Watches all product categories sorted by name.
  Stream<List<ProductCategoryRow>> watchAll() {
    return _selectOrdered().watch();
  }

  /// Fetches a one-off snapshot of all product categories.
  Future<List<ProductCategoryRow>> getAll() {
    return _selectOrdered().get();
  }

  /// Watches active product categories sorted by name.
  Stream<List<ProductCategoryRow>> watchActive() {
    return (_selectOrdered()..where((c) => c.isActive.equals(true))).watch();
  }

  /// Fetches a one-off snapshot of active product categories.
  Future<List<ProductCategoryRow>> getActive() {
    return (_selectOrdered()..where((c) => c.isActive.equals(true))).get();
  }

  /// Fetches a category by its unique ID.
  Future<ProductCategoryRow?> getById(int id) {
    return (select(productCategories)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  /// Fetches a category by name using case-insensitive matching.
  Future<ProductCategoryRow?> getByName(String name) {
    return (select(productCategories)
      ..where((c) => c.name.equals(name)))
        .getSingleOrNull();
  }

  /// Inserts a new product category and returns the generated row ID.
  Future<int> insertCategory(ProductCategoriesCompanion category) {
    return into(productCategories).insert(category);
  }

  /// Updates an existing category by ID.
  Future<int> updateCategory(int id, ProductCategoriesCompanion category) {
    return (update(productCategories)..where((c) => c.id.equals(id)))
        .write(category);
  }

  /// Updates the active status of a category by ID.
  Future<int> setActiveStatus(int id, bool isActive) {
    return updateCategory(
      id,
      ProductCategoriesCompanion(isActive: Value(isActive)),
    );
  }

  /// Deletes a category by ID.
  Future<int> deleteById(int id) {
    return (delete(productCategories)..where((c) => c.id.equals(id))).go();
  }
}
