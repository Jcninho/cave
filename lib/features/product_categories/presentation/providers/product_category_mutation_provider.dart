import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
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
    return _runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.create(category);
    });
  }

  Future<Result<ProductCategoryEntity, Failure>> edit(
    ProductCategoryEntity category,
  ) {
    return _runMutation(
            () {
          final repo = ref.read(productCategoryRepositoryProvider);
          return repo.update(category);
        }
    );
  }

  Future<Result<void, Failure>> deactivate(int id) {
    return _runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.deactivate(id);
    });
  }

  Future<Result<void, Failure>> activate(int id) {
    return _runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.activate(id);
    });
  }

  Future<Result<void, Failure>> deleteById(int id) {
    return _runMutation(() {
      final repo = ref.read(productCategoryRepositoryProvider);
      return repo.deleteById(id);
    });
  }

  Future<Result<T, Failure>> _runMutation<T>(
    Future<Result<T, Failure>> Function() action,
  ) async {
    state = const AsyncLoading<void>();

    try {
      final result = await action();
      state = const AsyncData<void>(null);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError<void>(error, stackTrace);
      rethrow;
    }
  }
}
