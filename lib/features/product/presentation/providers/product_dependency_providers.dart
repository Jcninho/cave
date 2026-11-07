import 'package:cave/core/database/app_database_provider.dart';
import 'package:cave/features/product/data/datasources/product_dao.dart';
import 'package:cave/features/product/data/repositories/product_repository_impl.dart';
import 'package:cave/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDaoProvider = Provider<ProductDao>((ref) {
  return ProductDao(ref.watch(appDatabaseProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productDaoProvider));
});
