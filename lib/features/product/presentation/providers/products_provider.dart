import 'package:cave/features/product/domain/entities/product_entity.dart';
import 'package:cave/features/product/presentation/providers/product_dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = StreamProvider.autoDispose<List<ProductEntity>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.watchAll();
});

final activeProductsProvider = StreamProvider.autoDispose<List<ProductEntity>>((
  ref,
) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.watchActive();
});

final productCategoryProvider = StreamProvider.autoDispose
    .family<ProductEntity?, int>((ref, id) {
      final repository = ref.watch(productRepositoryProvider);
      return repository.watchAll().map(
        (list) => list.where((c) => c.id == id).firstOrNull,
      );
    });
