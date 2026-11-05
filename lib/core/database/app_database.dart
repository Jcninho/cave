
import 'dart:io';

import 'package:cave/core/database/tables/tables.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ProductCategoriesTable], daos: [])
class AppDatabase  extends _$AppDatabase {
  AppDatabase(): super(_openConnection());

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


LazyDatabase _openConnection() => LazyDatabase(() async{
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'cave.db'));
  return NativeDatabase.createInBackground(file);
});
