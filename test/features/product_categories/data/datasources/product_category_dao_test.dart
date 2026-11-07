import 'package:async/async.dart';
import 'package:cave/core/database/app_database.dart';
import 'package:cave/features/product_categories/data/datasources/product_category_dao.dart';
import 'package:cave/features/product_categories/data/mappers/product_category_mapper.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProductCategoryDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = ProductCategoryDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ProductCategoryDao', () {
    group('insertCategory', () {
      test('insère correctement une catégorie', () async {
        // ARRANGE
        final sodaCategory = const ProductCategoryEntity(
          name: 'Soda',
          isActive: true,
        );

        final companion = sodaCategory.toCompanion();

        // ACT
        final result = await dao.insertCategory(companion);

        // ASSERT
        expect(result, greaterThan(0));

        final categoryRow = await dao.getById(result);
        final categoryEntity = categoryRow?.toDomain();

        expect(categoryEntity, isNotNull);
        expect(categoryEntity?.name, sodaCategory.name);
        expect(categoryEntity?.isActive, sodaCategory.isActive);
        expect(categoryEntity?.imageUrl, sodaCategory.imageUrl);
      });
    });
    group('getById', () {
      test("test l'existence d'une catégorie", () async {
        final category = const ProductCategoryEntity(
          name: 'Soda',
          isActive: true,
        );
        final companion = category.toCompanion();

        final id = await dao.insertCategory(companion);

        final exists = await dao.getById(id);
        expect(exists, isNotNull);
      });
    });
    group('updateCategory', () {
      test('modifie correctement une catégorie', () async {
        // ARRANGE
        final category = const ProductCategoryEntity(
          name: 'Soda',
          isActive: true,
        );

        final id = await dao.insertCategory(category.toCompanion());

        final existing = await dao.getById(id);

        expect(existing, isNotNull);

        final updated = existing!.toDomain().copyWith(
          name: 'Boissons gazeuses',
        );

        // ACT
        final result = await dao.updateCategory(id, updated.toCompanion());

        // ASSERT
        expect(result, greaterThan(0));

        final refreshed = await dao.getById(id);

        expect(refreshed, isNotNull);
        expect(refreshed?.name, 'Boissons gazeuses');
        expect(refreshed?.isActive, true);
        expect(refreshed?.id, id);
      });
      test('ne modifie aucune catégorie si ID inexistant', () async {
        // ARRANGE
        final category = const ProductCategoryEntity(
          name: 'Boissons gazeuses',
          isActive: true,
        );
        final companion = category.toCompanion();

        final updated = await dao.updateCategory(999, companion);

        expect(updated, 0);
      });
    });
    group('deleteCategory', () {
      test('supprime correctement une catégorie', () async {
        // ARRANGE
        final category = const ProductCategoryEntity(
          name: 'Soda',
          isActive: true,
        );

        final companion = category.toCompanion();

        final id = await dao.insertCategory(companion);

        expect(id, greaterThan(0));

        // ACT
        final result = await dao.deleteById(id);

        // ASSERT
        expect(result, 1);

        final deleted = await dao.getById(id);

        expect(deleted, isNull);


      });
      test('ne supprime aucune catégorie si ID inexistant', () async {
        // ARRANGE
        final result = await dao.deleteById(999);
        expect(result, 0);
      });
    });
    group("watchAll", (){
      test('watchAll émet une liste vide initialement', () async {
        await expectLater(
          dao.watchAll(),
          emits(isEmpty),
        );
      });
      test('watchAll réagit aux insertions et suppressions', () async {
        final category = const ProductCategoryEntity(
          name: 'Soda',
          isActive: true,
        );

        final expectation = expectLater(
          dao.watchAll(),
          emitsInOrder([
            hasLength(1),
            hasLength(0),
          ]),
        );

        final id = await dao.insertCategory(
          category.toCompanion(),
        );

        expect(id, greaterThan(0));

        final deleted = await dao.deleteById(id);

        expect(deleted, 1);

        await expectation;
      });
      test('watchAll emits categories when data changes', () async {
        final category = const ProductCategoryEntity(
          name: 'Soda',
          isActive: true,
        );
        // 1. Démarrer l'écoute du Stream
        final queue = StreamQueue(dao.watchAll());

        try {
          // 2. Vérifier l'état initial
          final initialCategories = await queue.next;

          expect(initialCategories, isEmpty);

          // 3. Insérer une catégorie
          final id = await dao.insertCategory(
            category.toCompanion(),
          );

          expect(id, greaterThan(0));

          // 4. Attendre la nouvelle émission
          final categoriesAfterInsert = await queue.next;

          expect(categoriesAfterInsert, hasLength(1));
          expect(categoriesAfterInsert.single.name, 'Soda');

          // 5. Supprimer la catégorie
          final deletedRows = await dao.deleteById(id);

          expect(deletedRows, 1);

          // 6. Attendre la dernière émission
          final categoriesAfterDelete = await queue.next;

          expect(categoriesAfterDelete, isEmpty);
        } finally {
          // 7. Fermer proprement l'écoute
          await queue.cancel();
        }
      });
    });
  });
}
