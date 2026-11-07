import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/core/utils/run_mutation.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:cave/features/product_categories/presentation/providers/product_category_dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productCategoryMutationProvider =
    AsyncNotifierProvider.autoDispose<ProductCategoryMutationNotifier, void>(
      ProductCategoryMutationNotifier.new,
    );

class ProductCategoryMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Result<ProductCategoryEntity, Failure>> create(
    ProductCategoryEntity category,
  ) {
    return runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.create(category);
    },state);
  }

  Future<Result<ProductCategoryEntity, Failure>> edit(
    ProductCategoryEntity category,
  ) {
    return runMutation(
            () {
          final repo = ref.read(productCategoryRepositoryProvider);
          return repo.update(category);
        }, state
    );
  }

  Future<Result<void, Failure>> deactivate(int id) {
    return runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.deactivate(id);
    },state);
  }

  Future<Result<void, Failure>> activate(int id) {
    return runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.activate(id);
    },state);
  }

  Future<Result<void, Failure>> deleteById(int id) {
    return runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.deleteById(id);
    },state);
  }
}
