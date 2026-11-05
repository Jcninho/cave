import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/core/utils/map_stream_list.dart';
import 'package:cave/core/utils/normalize.dart';
import 'package:cave/features/product_categories/data/datasources/product_category_dao.dart';
import 'package:cave/features/product_categories/data/mappers/product_category_mapper.dart';
import 'package:cave/features/product_categories/domain/entities/product_category_entity.dart';
import 'package:cave/features/product_categories/domain/repositories/product_category_repository.dart';
import 'package:drift/drift.dart';

class ProductCategoryRepositoryImpl implements ProductCategoryRepository {
  final ProductCategoryDao _dao;

  ProductCategoryRepositoryImpl(this._dao);

  @override
  Future<Result<void, Failure>> activate(int id) => _toggle(id, true);

  @override
  Future<Result<ProductCategoryEntity, Failure>> create(
    ProductCategoryEntity category,
  ) async {
    final normalizeName = normalize(category.name);

    if (normalizeName.isEmpty) {
      return Result.failure(
        const ValidationFailure('Le nom de la catégorie est obligatoire.'),
      );
    }

    try {
      final existing = await _dao.getByName(normalizeName);

      if (existing != null) {
        return Result.failure(
          const ConflictFailure('Une catégorie utilise déjà ce nom.'),
        );
      }

      final id = await _dao.insertCategory(
        category.toCompanion().copyWith(name: Value(normalizeName)),
      );

      final created = await _dao.getById(id);

      if (created == null) {
        return Result.failure(
          const DataFailure(
            'La catégorie a été enregistrée, mais sa relecture a échoué.',
          ),
        );
      }

      return Result.success(created.toDomain());
    } catch (error, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de créer la catégorie.', stackTrace),
      );
    }
  }

  @override
  Future<Result<void, Failure>> deactivate(int id) => _toggle(id, false);

  @override
  Future<Result<void, Failure>> deleteById(int id) async {
    if (id <= 0) {
      return Result.failure(
        const ValidationFailure("L'identifiant de la catégories est invalide"),
      );
    }

    try {
      final affectedRows = await _dao.deleteById(id);

      if (affectedRows == 0) {
        return Result.failure(
          const NotFoundFailure('La catégorie à supprimée est introuvable.'),
        );
      }

      return Result.success(null);

    } catch (e, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de supprimer la catégorie.', stackTrace),
      );
    }
  }

  @override
  Future<Result<List<ProductCategoryEntity>, Failure>> getActive() async{
    try{
      final result = await _dao.getActive();
      return Result.success(result.toDomainList());
    } catch(e, stackTrace){
      return Result.failure(
        DataFailure('Impossible de récupérer les catégories actives.', stackTrace),
      );
    }
  }

  @override
  Future<Result<List<ProductCategoryEntity>, Failure>> getAll() async{
    try{
      final result = await _dao.getAll();
      return Result.success(result.toDomainList());
    } catch(e, stackTrace){
      return Result.failure(
        DataFailure('Impossible de récupérer les catégories.', stackTrace),
      );
    }
  }

  @override
  Future<Result<ProductCategoryEntity?, Failure>> getById(int id) async{

    if (id <= 0) {
      return Result.failure(
        const ValidationFailure('L’identifiant de la catégorie est invalide.'),
      );
    }

    try{
      final result = await _dao.getById(id);
      return Result.success(result?.toDomain());
    } catch(e, stackTrace){
      return Result.failure(
        DataFailure('Impossible de récupérer la catégorie.', stackTrace),
      );
    }
  }

  @override
  Future<Result<ProductCategoryEntity, Failure>> update(
    ProductCategoryEntity category,
  ) async{
    final id = category.id;

    if(id == null || id <= 0){
      return Result.failure(
        const ValidationFailure('L’identifiant de la catégorie est invalide.'),
      );
    }

    final normalizeName = normalize(category.name);
    if(normalizeName.isEmpty){
      return Result.failure(
        const ValidationFailure('Le nom de la catégorie est obligatoire.'),
      );
    }

    try{
      final existing = await _dao.getById(id);
      if (existing == null) {
        return Result.failure(
          const NotFoundFailure('La catégorie demandée est introuvable.'),
        );
      }

      final conflictingName = await _dao.getByName(normalizeName);
      if(conflictingName != null && conflictingName.id != id){
        return Result.failure(
          const ConflictFailure('Une catégorie utilise déjà ce nom.'),
        );

      }

      final affectedRows = await _dao.updateCategory(
        id,
        category.toCompanion().copyWith(name: Value(normalizeName)),
      );
      if (affectedRows == 0) {
        return Result.failure(
          const NotFoundFailure('La catégorie demandée est introuvable.'),
        );
      }

      final refreshed = await _dao.getById(id);

      if (refreshed == null) {
        return Result.failure(
          const DataFailure('Impossible de relire la catégorie modifiée.'),
        );
      }

      return Result.success(refreshed.toDomain());
    } catch (error, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de modifier la catégorie.', stackTrace),
      );
    }
  }

  @override
  Stream<List<ProductCategoryEntity>> watchActive() {
    return mapStreamList(_dao.watchActive(), (rows) => rows.toDomain());
  }

  @override
  Stream<List<ProductCategoryEntity>> watchAll() {
    return mapStreamList(_dao.watchAll(), (rows) => rows.toDomain());
  }

  Future<Result<void, Failure>> _toggle(int id, bool isActive) async {
    if (id <= 0) {
      return Result.failure(
        const ValidationFailure("L'identifiant de la catégories est invalide"),
      );
    }

    try {
      final existing = await _dao.getById(id);

      if (existing == null) {
        return Result.failure(
          const NotFoundFailure('La catégorie demandée est introuvable.'),
        );
      }

      if (existing.isActive == isActive) {
        return Result.success(null);
      }

      final affectedRows = await _dao.setActiveStatus(id, isActive);

      if (affectedRows == 0) {
        return Result.failure(
          const NotFoundFailure('La catégorie demandée est introuvable.'),
        );
      }

      return Result.success(null);
    } catch (e, stackTrace) {
      return Result.failure(
        DataFailure(
          isActive
              ? 'Impossible de réactiver la catégorie.'
              : 'Impossible de désactiver la catégorie.',
          stackTrace,
        ),
      );
    }
  }
}
