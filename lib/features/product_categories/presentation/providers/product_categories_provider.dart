import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:cave/features/product_categories/presentation/providers/product_category_dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productCategoriesProvider =
    StreamProvider.autoDispose<List<ProductCategoryEntity>>((ref) {
      final repo = ref.watch(productCategoryRepositoryProvider);
      return repo.watchAll();
    });

final activeProductCategoriesProvider =
    StreamProvider.autoDispose<List<ProductCategoryEntity>>((ref) {
      final repo = ref.watch(productCategoryRepositoryProvider);
      return repo.watchActive();
    });


final productCategoryProvider = StreamProvider.autoDispose
    .family<ProductCategoryEntity?, int>((ref, id) {
  final repository = ref.watch(productCategoryRepositoryProvider);
  return repository.watchAll().map(
        (list) => list.where((c) => c.id == id).firstOrNull,
  );
});
