import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDatasource remoteDatasource;

  ProductsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<Product>>> fetchAllProducts() async {
    try {
      final products = await remoteDatasource.fetchAllProducts();
      return right(products);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
