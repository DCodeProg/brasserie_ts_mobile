import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/panier.dart';
import '../entities/panier_item.dart';
import '../repositories/panier_repository.dart';

class AddItem implements UseCase<Panier, AddItemParams> {
  final PanierRepository panierRepository;

  AddItem({required this.panierRepository});

  @override
  Future<Either<Failure, Panier>> call(AddItemParams params) async {
    return await panierRepository.addItem(itemId: params.itemId, quantite: params.quantite);
  }
}

class AddItemParams {
  final String itemId;
  final int quantite;
  AddItemParams({required this.itemId, required this.quantite});
}
