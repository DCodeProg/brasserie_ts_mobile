import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract interface class ProductsRepository {
  Future<Either<Failure, List<Product>>> fetchAllProducts();
}
