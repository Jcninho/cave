import 'package:cave/features/product_units/domain/entities/product_unit_entity.dart';
import 'package:cave/features/product_units/presentation/providers/product_unit_dependency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productUnitsProvider =
    StreamProvider.autoDispose<List<ProductUnitEntity>>((ref) {
      final repo = ref.watch(productUnitRepositoryProvider);
      return repo.watchAll();
    });

final productUnitProvider = StreamProvider.autoDispose
    .family<ProductUnitEntity?, int>((ref, id) {
      final repository = ref.watch(productUnitRepositoryProvider);
      return repository.watchAll().map(
        (list) => list.where((c) => c.id == id).firstOrNull,
      );
    });
