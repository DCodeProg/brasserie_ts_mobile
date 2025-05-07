import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/panier.dart';
import '../repositories/panier_repository.dart';

class RemoveItem implements UseCase<Panier, RemoveItemParams> {
  final PanierRepository panierRepository;

  RemoveItem({required this.panierRepository});

  @override
  Future<Either<Failure, Panier>> call(RemoveItemParams params) async {
    return await panierRepository.removeItem(itemId: params.itemId);
  }
}

class RemoveItemParams {
  final String itemId;

  RemoveItemParams({required this.itemId});
}
