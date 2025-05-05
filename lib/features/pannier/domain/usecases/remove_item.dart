import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pannier.dart';
import '../repositories/pannier_repository.dart';

class RemoveItem implements UseCase<Pannier, RemoveItemParams> {
  final PannierRepository pannierRepository;

  RemoveItem({required this.pannierRepository});

  @override
  Future<Either<Failure, Pannier>> call(RemoveItemParams params) async {
    return await pannierRepository.removeItem(itemId: params.itemId);
  }
}

class RemoveItemParams {
  final String itemId;

  RemoveItemParams({required this.itemId});
}
