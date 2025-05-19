import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> signInWithPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String nom,
    required String prenom,
  });
  Future<Either<Failure, User>> updateAccountData({
    required String? nom,
    required String? prenom,
  });
  Future<Either<Failure, User>> updateEmail({required String email});
}
