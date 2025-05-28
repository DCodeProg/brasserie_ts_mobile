import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class FetchAllProducts implements UseCase<List<Product>, NoParams> {
  final ProductsRepository productsRepository;

  FetchAllProducts({required this.productsRepository});

  @override
  Future<Either<Failure, List<Product>>> call([NoParams? params]) async {
    return await productsRepository.fetchAllProducts();
  }
}
