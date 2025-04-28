import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithPassword implements UseCase<User, SignInWithPasswordParams> {
  final AuthRepository authRepository;

  SignInWithPassword({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.signInWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithPasswordParams {
  final String email;
  final String password;

  SignInWithPasswordParams({required this.email, required this.password});
}
