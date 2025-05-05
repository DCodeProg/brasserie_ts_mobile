import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await remoteDatasource.getCurrentUser();
      if (user != null) {
        return right(user);
      } else {
        return left(ServerFailure(message: "User not logged in"));
      }
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDatasource.signInWithPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDatasource.signOut();
      // ignore: void_checks
      return right(unit);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required DateTime dateNaissance,
  }) async {
    try {
      final user = await remoteDatasource.signUp(
        email: email,
        password: password,
        nom: nom,
        prenom: prenom,
        dateNaissance: dateNaissance,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateAccountData({
    required String? nom,
    required String? prenom,
    required DateTime? dateNaissance,
  }) {
    // TODO: implement updateAccountData
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, User>> updateEmail({required String email}) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }
}
