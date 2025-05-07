import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/panier.dart';
import '../../domain/repositories/panier_repository.dart';
import '../datasources/panier_local_datasource.dart';

class PanierRepositoryImpl implements PanierRepository {
  final PanierLocalDatasource localDatasource;

  PanierRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<Failure, Panier>> addItem({
    required String itemId,
    required int quantite,
  }) async {
    try {
      final panier = await localDatasource.addItem(
        itemId: itemId,
        quantite: quantite,
      );
      return right(panier);
    } catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Panier>> clearItems() async {
    try {
      final panier = await localDatasource.clearItems();
      return right(panier);
    } catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Panier>> loadPanier() async {
    try {
      final panier = await localDatasource.loadPanier();
      return right(panier);
    } catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Panier>> removeItem({required String itemId}) async {
    try {
      final panier = await localDatasource.removeItem(itemId: itemId);
      return right(panier);
    } catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Panier>> updateItemQuantity({
    required String itemId,
    required int quantite,
  }) async {
    try {
      final panier = await localDatasource.updateItemQuantity(
        itemId: itemId,
        quantite: quantite,
      );
      return right(panier);
    } catch (e) {
      return left(CacheFailure(message: e.toString()));
    }
  }
}
