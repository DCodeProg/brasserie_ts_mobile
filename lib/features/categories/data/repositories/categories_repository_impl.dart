import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_remote_datasource.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDatasource remoteDatasource;

  CategoriesRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<Category>>> fetchAllCategories() async {
    try {
      final categories = await remoteDatasource.fetchAllCategories();
      return right(categories);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
