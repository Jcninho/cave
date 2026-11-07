
import 'package:cave/core/database/app_database_provider.dart';
import 'package:cave/features/product_categories/data/datasources/product_category_dao.dart';
import 'package:cave/features/product_categories/data/repositories/product_category_repository_impl.dart';
import 'package:cave/features/product_categories/domain/repositories/product_category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productCategoryDaoProvider = Provider<ProductCategoryDao>((ref) {
  return ProductCategoryDao(ref.watch(appDatabaseProvider));
});

final productCategoryRepositoryProvider = Provider<ProductCategoryRepository>((ref) {
  return ProductCategoryRepositoryImpl(ref.watch(productCategoryDaoProvider));
});
