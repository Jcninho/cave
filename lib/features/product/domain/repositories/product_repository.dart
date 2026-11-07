import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/features/product/domain/entities/product_entity.dart';

abstract interface class ProductRepository {
  Stream<List<ProductEntity>> watchAll();

  Stream<List<ProductEntity>> watchActive();

  Future<Result<List<ProductEntity>, Failure>> getAll();

  Future<Result<List<ProductEntity>, Failure>> getActive();

  Future<Result<ProductEntity?, Failure>> getById(int id);

  Future<Result<ProductEntity, Failure>> create(ProductEntity product);

  Future<Result<ProductEntity, Failure>> update(ProductEntity product);

  Future<Result<void, Failure>> deleteById(int id);

  Future<Result<void, Failure>> deactivate(int id);

  Future<Result<void, Failure>> activate(int id);
}
