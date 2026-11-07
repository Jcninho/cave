
import 'package:cave/core/database/app_database_provider.dart';
import 'package:cave/features/product_units/data/datasources/product_unit_dao.dart';
import 'package:cave/features/product_units/data/repositories/product_unit_repository_impl.dart';
import 'package:cave/features/product_units/domain/repositories/product_unit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productUnitDaoProvider = Provider<ProductUnitDao>((ref) {
  return ProductUnitDao(ref.watch(appDatabaseProvider));
});

final productUnitRepositoryProvider = Provider<ProductUnitRepository>((ref) {
  return ProductUnitRepositoryImpl(ref.watch(productUnitDaoProvider));
});
