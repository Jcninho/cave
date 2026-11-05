import 'package:cave/core/database/app_database.dart';
import 'package:cave/core/database/tables/product_categories_table.dart';
import 'package:drift/drift.dart';

part 'product_category_dao.g.dart';

@DriftAccessor(tables: [ProductCategoriesTable])
class ProductCategoryDao extends DatabaseAccessor<AppDatabase>
    with _$ProductCategoryDaoMixin {
  ProductCategoryDao(super.db);
}
