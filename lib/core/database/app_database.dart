import 'dart:io';

import 'package:cave/core/database/tables/tables.dart';
import 'package:cave/features/product/data/datasources/product_dao.dart';
import 'package:cave/features/product_categories/data/datasources/product_category_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [ProductCategories, Products, ProductUnits],
  daos: [ProductCategoryDao, ProductDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {},
    beforeOpen: (details) async {},
  );
}

LazyDatabase _openConnection() => LazyDatabase(() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'cave.db'));
  return NativeDatabase.createInBackground(file);
});
