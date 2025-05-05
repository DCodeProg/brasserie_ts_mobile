import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pannier.dart';
import '../entities/pannier_item.dart';
import '../repositories/pannier_repository.dart';

class AddItem implements UseCase<Pannier, AddItemParams> {
  final PannierRepository pannierRepository;

  AddItem({required this.pannierRepository});

  @override
  Future<Either<Failure, Pannier>> call(AddItemParams params) async {
    return await pannierRepository.addItem(pannierItem: params.pannierItem);
  }
}

class AddItemParams {
  final PannierItem pannierItem;

  AddItemParams({required this.pannierItem});
}
