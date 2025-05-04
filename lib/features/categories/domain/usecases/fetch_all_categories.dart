import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../repositories/categories_repository.dart';

class FetchAllCategories implements UseCase<List<Category>, NoParams> {
  final CategoriesRepository categoriesRepository;

  FetchAllCategories({required this.categoriesRepository});

  @override
  Future<Either<Failure, List<Category>>> call([NoParams? params]) async {
    return await categoriesRepository.fetchAllCategories();
  }
}
