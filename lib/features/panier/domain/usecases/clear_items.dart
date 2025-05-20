import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/panier.dart';
import '../repositories/panier_repository.dart';

class ClearItems implements UseCase<Panier, NoParams> {
  final PanierRepository panierRepository;

  ClearItems({required this.panierRepository});

  @override
  Future<Either<Failure, Panier>> call([NoParams? params]) async {
    return await panierRepository.clearItems();
  }
}
