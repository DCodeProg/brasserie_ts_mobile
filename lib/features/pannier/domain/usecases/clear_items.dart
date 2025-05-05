import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pannier.dart';
import '../repositories/pannier_repository.dart';

class ClearItems implements UseCase<Pannier, NoParams> {
  final PannierRepository pannierRepository;

  ClearItems({required this.pannierRepository});

  @override
  Future<Either<Failure, Pannier>> call([NoParams? params]) async {
    return await pannierRepository.clearItems();
  }
}
