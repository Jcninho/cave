
import 'package:cave/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late AppDatabase db;
  setUp((){
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async{
    await db.close();
  });

  test('Initialise correctement la bd', () async{
    final categories = await db.select(db.productCategories).get();
    
    expect(categories, isEmpty);
  });
}
