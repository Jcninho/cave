import 'package:cave/core/database/app_database.dart';
import 'package:cave/core/database/tables/product_units_table.dart';
import 'package:drift/drift.dart';

part 'product_unit_dao.g.dart';

@DriftAccessor(tables: [ProductUnits])
class ProductUnitDao extends DatabaseAccessor<AppDatabase>
    with _$ProductUnitDaoMixin {
  ProductUnitDao(super.db);

  /// Helper base query to apply consistent ordering by unit name.
  SimpleSelectStatement<$ProductUnitsTable, ProductUnitRow>
  _selectOrdered() {
    return select(productUnits)
      ..orderBy([(c) => OrderingTerm.asc(c.name)]);
  }

  /// Watches all product categories sorted by name.
  Stream<List<ProductUnitRow>> watchAll() {
    return _selectOrdered().watch();
  }

  /// Fetches a one-off snapshot of all product categories.
  Future<List<ProductUnitRow>> getAll() {
    return _selectOrdered().get();
  }

  /// Fetches a unit by its unique ID.
  Future<ProductUnitRow?> getById(int id) {
    return (select(productUnits)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  /// Fetches a unit by name using case-insensitive matching.
  Future<ProductUnitRow?> getByName(String name) {
    return (select(productUnits)
      ..where((c) => c.name.equals(name)))
        .getSingleOrNull();
  }

  /// Inserts a new product unit and returns the generated row ID.
  Future<int> insertUnit(ProductUnitsCompanion unit) {
    return into(productUnits).insert(unit);
  }

  /// Updates an existing unit by ID.
  Future<int> updateUnit(int id, ProductUnitsCompanion unit) {
    return (update(productUnits)..where((c) => c.id.equals(id)))
        .write(unit);
  }

  /// Deletes a unit by ID.
  Future<int> deleteById(int id) {
    return (delete(productUnits)..where((c) => c.id.equals(id))).go();
  }
}
