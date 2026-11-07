import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/core/utils/run_mutation.dart';
import 'package:cave/features/product_units/domain/entities/product_unit_entity.dart';
import 'package:cave/features/product_units/presentation/providers/product_unit_dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUnitMutationProvider =
    AsyncNotifierProvider.autoDispose<ProductUnitMutationNotifier, void>(
      ProductUnitMutationNotifier.new,
    );

class ProductUnitMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Result<ProductUnitEntity, Failure>> create(
    ProductUnitEntity category,
  ) {
    return runMutation(() {
      final repo = ref.read(productUnitRepositoryProvider);
      return repo.create(category);
    }, state);
  }

  Future<Result<ProductUnitEntity, Failure>> edit(ProductUnitEntity category) {
    return runMutation(() {
      final repo = ref.read(productUnitRepositoryProvider);
      return repo.update(category);
    }, state);
  }

  Future<Result<void, Failure>> deleteById(int id) {
    return runMutation(() {
      final repo = ref.read(productUnitRepositoryProvider);
      return repo.deleteById(id);
    }, state);
  }
}
