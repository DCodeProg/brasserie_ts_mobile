import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUp implements UseCase<User, SignUpParams> {
  final AuthRepository authRepository;

  SignUp({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(params) async {
    return await authRepository.signUp(
      email: params.email,
      password: params.password,
      nom: params.nom,
      prenom: params.prenom,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String nom;
  final String prenom;

  SignUpParams({
    required this.email,
    required this.password,
    required this.nom,
    required this.prenom,
  });
}
