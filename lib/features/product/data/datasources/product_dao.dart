
import 'package:cave/core/database/app_database.dart';
import 'package:cave/core/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  /// Helper base query to apply consistent ordering by category name.
  SimpleSelectStatement<$ProductsTable, ProductRow>
  _selectOrdered() {
    return select(products)
      ..orderBy([(c) => OrderingTerm.asc(c.name)]);
  }

  /// Watches all product categories sorted by name.
  Stream<List<ProductRow>> watchAll() {
    return _selectOrdered().watch();
  }

  /// Fetches a one-off snapshot of all product categories.
  Future<List<ProductRow>> getAll() {
    return _selectOrdered().get();
  }

  /// Watches active product categories sorted by name.
  Stream<List<ProductRow>> watchActive() {
    return (_selectOrdered()..where((c) => c.isActive.equals(true))).watch();
  }

  /// Fetches a one-off snapshot of active product categories.
  Future<List<ProductRow>> getActive() {
    return (_selectOrdered()..where((c) => c.isActive.equals(true))).get();
  }

  /// Fetches a category by its unique ID.
  Future<ProductRow?> getById(int id) {
    return (select(products)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  /// Fetches a category by name using case-insensitive matching.
  Future<ProductRow?> getByName(String name) {
    return (select(products)
      ..where((c) => c.name.equals(name)))
        .getSingleOrNull();
  }

  /// Inserts a new product category and returns the generated row ID.
  Future<int> insertProduct(ProductsCompanion category) {
    return into(products).insert(category);
  }

  /// Updates an existing category by ID.
  Future<int> updateProduct(int id, ProductsCompanion category) {
    return (update(products)..where((c) => c.id.equals(id)))
        .write(category);
  }

  /// Updates the active status of a category by ID.
  Future<int> setActiveStatus(int id, bool isActive) {
    return updateProduct(
      id,
      ProductsCompanion(isActive: Value(isActive)),
    );
  }

  /// Deletes a category by ID.
  Future<int> deleteById(int id) {
    return (delete(products)..where((c) => c.id.equals(id))).go();
  }

}
