


import 'package:cave/core/database/tables/products_table.dart';
import 'package:drift/drift.dart';

@DataClassName('ProductUnitRow')
class ProductUnits extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer().references(Products, #id)();
  TextColumn get name => text().unique()();
  IntColumn get conversionFactor => integer()();
  RealColumn get sellingPrice => real()();
  BoolColumn get isSellable => boolean()();
  BoolColumn get isPurchasable => boolean()();
}
