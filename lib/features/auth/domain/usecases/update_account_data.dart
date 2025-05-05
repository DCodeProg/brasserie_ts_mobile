import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class UpdateAccountData implements UseCase<User, UpdateAccountDataParams> {
  final AuthRepository authRepository;

  UpdateAccountData({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UpdateAccountDataParams params) async {
    return await authRepository.updateAccountData(
      nom: params.nom,
      prenom: params.prenom,
      dateNaissance: params.dateNaissance,
    );
  }
}

class UpdateAccountDataParams {
  final String? nom;
  final String? prenom;
  final DateTime? dateNaissance;

  UpdateAccountDataParams({
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
  });
}
