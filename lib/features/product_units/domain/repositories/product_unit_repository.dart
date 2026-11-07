
import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/features/product_units/domain/entities/product_unit_entity.dart';

abstract interface class ProductUnitRepository {
  Stream<List<ProductUnitEntity>> watchAll();


  Future<Result<List<ProductUnitEntity>, Failure>> getAll();

  Future<Result<ProductUnitEntity?, Failure>> getById(int id);

  Future<Result<ProductUnitEntity, Failure>> create(
      ProductUnitEntity category,
      );

  Future<Result<ProductUnitEntity, Failure>> update(
      ProductUnitEntity category,
      );

  Future<Result<void, Failure>> deleteById(int id);


}
