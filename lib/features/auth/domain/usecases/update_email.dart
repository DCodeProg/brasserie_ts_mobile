import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class UpdateEmail implements UseCase<User, UpdateEmailParams> {
  final AuthRepository authRepository;

  UpdateEmail({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UpdateEmailParams params) async {
    return await authRepository.updateEmail(email: params.email);
  }
}

class UpdateEmailParams {
  final String email;

  UpdateEmailParams({required this.email});
}
