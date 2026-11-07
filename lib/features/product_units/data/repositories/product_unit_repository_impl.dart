import 'package:cave/core/errors/failures.dart';
import 'package:cave/core/errors/result.dart';
import 'package:cave/core/utils/map_stream_list.dart';
import 'package:cave/core/utils/normalize.dart';
import 'package:cave/features/product_units/data/datasources/product_unit_dao.dart';
import 'package:cave/features/product_units/data/mappers/product_unit_mapper.dart';
import 'package:cave/features/product_units/domain/entities/product_unit_entity.dart';
import 'package:cave/features/product_units/domain/repositories/product_unit_repository.dart';
import 'package:drift/drift.dart';

class ProductUnitRepositoryImpl implements ProductUnitRepository {
  final ProductUnitDao _dao;

  ProductUnitRepositoryImpl(this._dao);

  @override
  Future<Result<ProductUnitEntity, Failure>> create(
    ProductUnitEntity category,
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

      final id = await _dao.insertUnit(
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
  Future<Result<List<ProductUnitEntity>, Failure>> getAll() async {
    try {
      final result = await _dao.getAll();
      return Result.success(result.toDomainList());
    } catch (e, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de récupérer les catégories.', stackTrace),
      );
    }
  }

  @override
  Future<Result<ProductUnitEntity?, Failure>> getById(int id) async {
    if (id <= 0) {
      return Result.failure(
        const ValidationFailure('L’identifiant de la catégorie est invalide.'),
      );
    }

    try {
      final result = await _dao.getById(id);
      return Result.success(result?.toDomain());
    } catch (e, stackTrace) {
      return Result.failure(
        DataFailure('Impossible de récupérer la catégorie.', stackTrace),
      );
    }
  }

  @override
  Future<Result<ProductUnitEntity, Failure>> update(
    ProductUnitEntity category,
  ) async {
    final id = category.id;

    if (id == null || id <= 0) {
      return Result.failure(
        const ValidationFailure('L’identifiant de la catégorie est invalide.'),
      );
    }

    final normalizeName = normalize(category.name);
    if (normalizeName.isEmpty) {
      return Result.failure(
        const ValidationFailure('Le nom de la catégorie est obligatoire.'),
      );
    }

    try {
      final existing = await _dao.getById(id);
      if (existing == null) {
        return Result.failure(
          const NotFoundFailure('La catégorie demandée est introuvable.'),
        );
      }

      final conflictingName = await _dao.getByName(normalizeName);
      if (conflictingName != null && conflictingName.id != id) {
        return Result.failure(
          const ConflictFailure('Une catégorie utilise déjà ce nom.'),
        );
      }

      final affectedRows = await _dao.updateUnit(
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
  Stream<List<ProductUnitEntity>> watchAll() {
    return mapStreamList(_dao.watchAll(), (rows) => rows.toDomain());
  }
}
