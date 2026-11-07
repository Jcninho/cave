import 'package:cave/core/errors/failures.dart';
import 'package:cave/features/product_categories/data/datasources/product_category_dao.dart';
import 'package:cave/features/product_categories/data/repositories/product_category_repository_impl.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductCategoryDao extends Mock implements ProductCategoryDao {}

void main() {
  late MockProductCategoryDao dao;
  late ProductCategoryRepositoryImpl repository;

  setUp(() {
    dao = MockProductCategoryDao();
    repository = ProductCategoryRepositoryImpl(dao);
  });

  group('ProductCategoryRepositoryImpl', () {
    group('create', () {
      test('create returns ValidationFailure when name is empty', () async {
        // Arrange
        final category = ProductCategoryEntity(
          name: '',
          id: null,
          isActive: true,
          imageUrl: null,
        );

        // Act
        final result = await repository.create(category);

        // Assert
        // 1. Vérifier que le résultat est un échec.
        expect(result.isFailure, isTrue);
        // 2. Vérifier que l'échec est un ValidationFailure.
        expect(result.failure, isA<ValidationFailure>());
        // 3. Vérifier le message.
        expect(
          result.failure.message,
          'Le nom de la catégorie est obligatoire.',
        );
        // 4. Vérifier que getByName n'a jamais été appelé.
        verifyNever(() => dao.getByName(any()));
      });
    });
  });
}
