import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/panier.dart';
import '../repositories/panier_repository.dart';

class UpdateItemQuantity implements UseCase<Panier, UpdateQuantityParams> {
  final PanierRepository panierRepository;

  UpdateItemQuantity({required this.panierRepository});

  @override
  Future<Either<Failure, Panier>> call(params) async {
    return await panierRepository.updateItemQuantity(
      itemId: params.itemId,
      quantity: params.quantity,
    );
  }
}

class UpdateQuantityParams {
  final String itemId;
  final int quantity;

  UpdateQuantityParams({
    required this.itemId,
    required this.quantity,
  });
}
