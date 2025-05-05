import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/pannier.dart';
import '../entities/pannier_item.dart';

abstract interface class PannierRepository {
  Future<Either<Failure, Pannier>> addItem({required PannierItem pannierItem});
  Future<Either<Failure, Pannier>> removeItem({required String itemId});
  Future<Either<Failure, Pannier>> updateItemQuantity({
    required PannierItem pannierItem,
  });
  Future<Either<Failure, Pannier>> clearItems();
}
