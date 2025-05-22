import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../produits/domain/entities/product.dart';
import '../entities/panier.dart';
import '../repositories/panier_repository.dart';

class AddItem implements UseCase<Panier, AddItemParams> {
  final PanierRepository panierRepository;

  AddItem({required this.panierRepository});

  @override
  Future<Either<Failure, Panier>> call(AddItemParams params) async {
    return await panierRepository.addItem(
      product: params.product,
      quantity: params.quantity,
    );
  }
}

class AddItemParams {
  final Product product;
  final int quantity;

  AddItemParams({
    required this.product,
    required this.quantity,
  });
}
