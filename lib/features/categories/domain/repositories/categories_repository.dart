import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/category.dart';

abstract interface class CategoriesRepository {
  Future<Either<Failure, List<Category>>> fetchAllCategories();
}