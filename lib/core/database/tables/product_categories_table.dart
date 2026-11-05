

import 'package:drift/drift.dart';

@DataClassName('ProductCategoryRow')
class ProductCategoriesTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
