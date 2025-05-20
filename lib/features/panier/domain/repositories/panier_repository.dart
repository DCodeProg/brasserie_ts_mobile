import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/panier.dart';

abstract interface class PanierRepository {
  Future<Either<Failure, Panier>> addItem({
    required String itemId,
    required int quantite,
  });
  Future<Either<Failure, Panier>> clearItems();
  Future<Either<Failure, Panier>> loadPanier();
  Future<Either<Failure, Panier>> removeItem({required String itemId});
  Future<Either<Failure, Panier>> updateItemQuantity({
    required String itemId,
    required int quantite,
  });
}
