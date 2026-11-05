
import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';

abstract interface class ProductRepository {
  Stream<List<ProductCategoryEntity>> watchAll();

  Stream<List<ProductCategoryEntity>> watchActive();

  Future<Result<ProductCategoryEntity?, Failure>> getById(int id);

  Future<Result<ProductCategoryEntity, Failure>> create(
      ProductCategoryEntity category,
      );

  Future<Result<ProductCategoryEntity, Failure>> update(
      ProductCategoryEntity category,
      );

  Future<Result<void, Failure>> delete(int id);

  Future<Result<void, Failure>> deactivate(int id);

  Future<Result<void, Failure>> activate(int id);
}
