import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/core/utils/run_mutation.dart';
import 'package:cave/features/product/domain/entities/product_entity.dart';
import 'package:cave/features/product/presentation/providers/product_dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productMutationProvider =
    AsyncNotifierProvider.autoDispose<ProductMutationNotifier, void>(
      ProductMutationNotifier.new,
    );

class ProductMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Result<ProductEntity, Failure>> create(ProductEntity category) {
    return runMutation(() {
      final repo = ref.read(productRepositoryProvider);
      return repo.create(category);
    }, state);
  }

  Future<Result<ProductEntity, Failure>> edit(ProductEntity category) {
    return runMutation(() {
      final repo = ref.read(productRepositoryProvider);
      return repo.update(category);
    }, state);
  }

  Future<Result<void, Failure>> deactivate(int id) {
    return runMutation(() {
      final repo = ref.read(productRepositoryProvider);
      return repo.deactivate(id);
    }, state);
  }

  Future<Result<void, Failure>> activate(int id) {
    return runMutation(() {
      final repo = ref.read(productRepositoryProvider);
      return repo.activate(id);
    }, state);
  }

  Future<Result<void, Failure>> deleteById(int id) {
    return runMutation(() {
      final repo = ref.read(productRepositoryProvider);
      return repo.deleteById(id);
    }, state);
  }
}
