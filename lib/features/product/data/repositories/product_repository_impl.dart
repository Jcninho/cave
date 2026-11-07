
import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/core/utils/map_stream_list.dart';
import 'package:cave/core/utils/normalize.dart';
import 'package:cave/features/product/data/datasources/product_dao.dart';
import 'package:cave/features/product/data/mappers/product_mapper.dart';
import 'package:cave/features/product/domain/entities/product_entity.dart';
import 'package:cave/features/product/domain/repositories/product_repository.dart';
import 'package:drift/drift.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDao _dao;

  ProductRepositoryImpl(this._dao);

  @override
  Future<Result<void, Failure>> activate(int id) => _toggle(id, true);

  @override
  Future<Result<ProductEntity, Failure>> create(
      ProductEntity category,
      ) async {
    final normalizeName = normalize(category.name);

    if (normalizeName.isEmpty) {
      return Result.failure(
        const ValidationFailure('Le nom du produit est obligatoire.'),
      );
    }

    try {
      final existing = await _dao.getByName(normalizeName);

      if (existing != null) {
        return Result.failure(
          const ConflictFailure('Un produit utilise déjà ce nom.'),
        );
      }

      final id = await _dao.insertProduct(
        category.toCompanion().copyWith(name: Value(normalizeName)),
      );

      final created = await _dao.getById(id);

      if (created == null) {
        return Result.failure(
          const DataFailure(
            'Le produit a été enregistré, mais sa relecture a échoué.',
          ),
        );
      }

      return Result.success(created.toDomain());
    } catch (error, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de créer le produit.', stackTrace),
      );
    }
  }

  @override
  Future<Result<void, Failure>> deactivate(int id) => _toggle(id, false);

  @override
  Future<Result<void, Failure>> deleteById(int id) async {
    if (id <= 0) {
      return Result.failure(
        const ValidationFailure("L'identifiant du produit est invalide"),
      );
    }

    try {
      final affectedRows = await _dao.deleteById(id);

      if (affectedRows == 0) {
        return Result.failure(
          const NotFoundFailure('Le produit supprimé est introuvable.'),
        );
      }

      return Result.success(null);

    } catch (e, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de supprimer le produit.', stackTrace),
      );
    }
  }

  @override
  Future<Result<List<ProductEntity>, Failure>> getActive() async{
    try{
      final result = await _dao.getActive();
      return Result.success(result.toDomainList());
    } catch(e, stackTrace){
      return Result.failure(
        DataFailure('Impossible de récupérer les produits actifs.', stackTrace),
      );
    }
  }

  @override
  Future<Result<List<ProductEntity>, Failure>> getAll() async{
    try{
      final result = await _dao.getAll();
      return Result.success(result.toDomainList());
    } catch(e, stackTrace){
      return Result.failure(
        DataFailure('Impossible de récupérer les produits.', stackTrace),
      );
    }
  }

  @override
  Future<Result<ProductEntity?, Failure>> getById(int id) async{

    if (id <= 0) {
      return Result.failure(
        const ValidationFailure('L’identifiant du produit est invalide.'),
      );
    }

    try{
      final result = await _dao.getById(id);
      return Result.success(result?.toDomain());
    } catch(e, stackTrace){
      return Result.failure(
        DataFailure('Impossible de récupérer le produit.', stackTrace),
      );
    }
  }

  @override
  Future<Result<ProductEntity, Failure>> update(
      ProductEntity product,
      ) async{
    final id = product.id;

    if(id == null || id <= 0){
      return Result.failure(
        const ValidationFailure('L’identifiant du produit invalide.'),
      );
    }

    final normalizeName = normalize(product.name);
    if(normalizeName.isEmpty){
      return Result.failure(
        const ValidationFailure('Le nom du produit est obligatoire.'),
      );
    }

    try{
      final existing = await _dao.getById(id);
      if (existing == null) {
        return Result.failure(
          const NotFoundFailure('Le produit demandé est introuvable.'),
        );
      }

      final conflictingName = await _dao.getByName(normalizeName);
      if(conflictingName != null && conflictingName.id != id){
        return Result.failure(
          const ConflictFailure('Un produit utilise déjà ce nom.'),
        );

      }

      final affectedRows = await _dao.updateProduct(
        id,
        product.toCompanion().copyWith(name: Value(normalizeName)),
      );
      if (affectedRows == 0) {
        return Result.failure(
          const NotFoundFailure('Le produit demandé est introuvable.'),
        );
      }

      final refreshed = await _dao.getById(id);

      if (refreshed == null) {
        return Result.failure(
          const DataFailure('Impossible de relire le produit modifié.'),
        );
      }

      return Result.success(refreshed.toDomain());
    } catch (error, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de modifier le produit.', stackTrace),
      );
    }
  }

  @override
  Stream<List<ProductEntity>> watchActive() {
    return mapStreamList(_dao.watchActive(), (rows) => rows.toDomain());
  }

  @override
  Stream<List<ProductEntity>> watchAll() {
    return mapStreamList(_dao.watchAll(), (rows) => rows.toDomain());
  }

  Future<Result<void, Failure>> _toggle(int id, bool isActive) async {
    if (id <= 0) {
      return Result.failure(
        const ValidationFailure("L'identifiant du produit est invalide"),
      );
    }

    try {
      final existing = await _dao.getById(id);

      if (existing == null) {
        return Result.failure(
          const NotFoundFailure('Le produit demandé est introuvable.'),
        );
      }

      if (existing.isActive == isActive) {
        return Result.success(null);
      }

      final affectedRows = await _dao.setActiveStatus(id, isActive);

      if (affectedRows == 0) {
        return Result.failure(
          const NotFoundFailure('Le produit demandé est introuvable.'),
        );
      }

      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(
        DataFailure(
          isActive
              ? 'Impossible de réactiver le produit.'
              : 'Impossible de désactiver le produit.',
          stackTrace,
        ),
      );
    }
  }
}
