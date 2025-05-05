import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call([NoParams? params]) async {
    return await authRepository.getCurrentUser();
  }
}
