import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class DeleteAccount implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  DeleteAccount({required this.authRepository});

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async {
    return await authRepository.deleteAccount();
  }
}
