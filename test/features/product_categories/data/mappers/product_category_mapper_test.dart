import 'package:cave/core/database/app_database.dart';
import 'package:cave/features/product_categories/data/mappers/product_category_mapper.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductCategoryDao', () {
    test(
      "vérifie la conversion entre les lignes Drift et les entités métier",
      () async {
        final categoryEntity = const ProductCategoryEntity(
          name: 'Boissons Gazeuses',
          isActive: true,
          id: 1,
          imageUrl: null,
        );

        final companion = categoryEntity.toCompanion();

        expect(companion, isA<ProductCategoriesCompanion>());
        expect(companion.name.value, 'Boissons Gazeuses');
        expect(companion.isActive.value, true);
        expect(companion.id.value, 1);
        expect(companion.imageUrl.value, isNull);

        final productCategoryRow = const ProductCategoryRow(id: 2, name: 'Jus', isActive: true);

        final entity = productCategoryRow.toDomain();

        expect(entity, isA<ProductCategoryEntity>());
        expect(entity.id, 2);
        expect(entity.name, 'Jus');
        expect(entity.isActive, true);
        expect(entity.imageUrl, isNull);
      },
    );
  });
}
