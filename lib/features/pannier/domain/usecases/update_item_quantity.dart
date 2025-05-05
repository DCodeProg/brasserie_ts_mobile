import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pannier.dart';
import '../entities/pannier_item.dart';
import '../repositories/pannier_repository.dart';

class UpdateItemQuantity implements UseCase<Pannier, UpdateQuantityParams> {
  final PannierRepository pannierRepository;

  UpdateItemQuantity({required this.pannierRepository});

  @override
  Future<Either<Failure, Pannier>> call(params) async {
    return await pannierRepository.updateItemQuantity(
      pannierItem: params.pannierItem,
    );
  }
}

class UpdateQuantityParams {
  final PannierItem pannierItem;

  UpdateQuantityParams({required this.pannierItem});
}
