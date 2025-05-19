import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:brasserie_ts_mobile/core/errors/exceptions.dart';
import 'package:brasserie_ts_mobile/core/errors/failures.dart';
import 'package:brasserie_ts_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:brasserie_ts_mobile/features/auth/data/models/user_model.dart';
import 'package:brasserie_ts_mobile/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(() {
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    authRepositoryImpl = AuthRepositoryImpl(
      remoteDatasource: mockAuthRemoteDatasource,
    );
  });

  final String tEmail = "john.doe@host-dcode.fr";
  final String tPassword = "J0hnD03!*21";
  final String tNom = "Doe";
  final String tPrenom = "John";
  final DateTime tCreatedAt = DateTime.now();

  final tUser = UserModel(
    uid: "21ff33c1-3087-4a80-89f1-c911eeed22bf",
    email: tEmail,
    nom: tNom,
    prenom: tPrenom,
    createdAt: tCreatedAt,
  );

  group("signInWithPassword", () {
    test("should return a User when the sign in is successful", () async {
      // arrange
      when(
        () => mockAuthRemoteDatasource.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => tUser);

      // act
      final res = await authRepositoryImpl.signInWithPassword(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(res, right(tUser));
      verify(
        () => mockAuthRemoteDatasource.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test("should return a Failure when the sign in have error", () async {
      // arrange
      final tServerException = ServerException(message: "An error occured!");
      when(
        () => mockAuthRemoteDatasource.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenThrow(tServerException);

      // act
      final res = await authRepositoryImpl.signInWithPassword(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(
        res,
        equals(left(ServerFailure(message: tServerException.message))),
      );
      verify(
        () => mockAuthRemoteDatasource.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });
  });

  group("signUp", () {
    test("should return a User when the sign up is successful", () async {
      // arrange
      when(
        () => mockAuthRemoteDatasource.signUp(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      ).thenAnswer((_) async => tUser);

      // act
      final res = await authRepositoryImpl.signUp(
        email: tEmail,
        password: tPassword,
        nom: tNom,
        prenom: tPrenom,
      );

      // assert
      expect(res, equals(right(tUser)));
      verify(
        () => mockAuthRemoteDatasource.signUp(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test("should return a Failure when the sign up have error", () async {
      // arrange
      final tServerException = ServerException(message: "An error occured!");
      when(
        () => mockAuthRemoteDatasource.signUp(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      ).thenThrow(tServerException);

      // act
      final res = await authRepositoryImpl.signUp(
        email: tEmail,
        password: tPassword,
        nom: tNom,
        prenom: tPrenom,
      );

      // assert
      expect(
        res,
        equals(left(ServerFailure(message: tServerException.message))),
      );
      verify(
        () => mockAuthRemoteDatasource.signUp(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });
  });

  group("getCurrentUser", () {
    test("should return a User when a session exist", () async {
      // arrange
      when(
        () => mockAuthRemoteDatasource.getCurrentUser(),
      ).thenAnswer((_) async => tUser);

      // act
      final res = await authRepositoryImpl.getCurrentUser();

      // assert
      expect(res, equals(right(tUser)));
    });

    test(
      "should return a AuthFailure when their is no existing session",
      () async {
        // arrange
        when(
          () => mockAuthRemoteDatasource.getCurrentUser(),
        ).thenAnswer((_) async => null);

        // act
        final res = await authRepositoryImpl.getCurrentUser();

        // assert
        expect(res, equals(left(AuthFailure(message: "User not logged in"))));
        verify(() => mockAuthRemoteDatasource.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDatasource);
      },
    );

    test(
      "should return a ServerFailure when getCurrentUser have an error",
      () async {
        // arrange
        final tServerException = ServerException(message: "Connexion error");
        when(
          () => mockAuthRemoteDatasource.getCurrentUser(),
        ).thenThrow(tServerException);

        // act
        final res = await authRepositoryImpl.getCurrentUser();

        // assert
        expect(
          res,
          equals(left(ServerFailure(message: tServerException.message))),
        );
        verify(() => mockAuthRemoteDatasource.getCurrentUser()).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDatasource);
      },
    );
  });

  group("signOut", () {
    test("should return null when the user is successfully sign out", () async {
      // arrange
      when(
        () => mockAuthRemoteDatasource.signOut(),
      ).thenAnswer((_) async => unit);

      // act
      final res = await authRepositoryImpl.signOut();

      // assert
      expect(res, right(unit));
      verify(() => mockAuthRemoteDatasource.signOut()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test(
      "should return a AuthFailure when the sign out have an error",
      () async {
        // arrange
        final tServerException = ServerException(message: "an error occured");
        when(
          () => mockAuthRemoteDatasource.signOut(),
        ).thenThrow(tServerException);

        // act
        final res = await authRepositoryImpl.signOut();

        // assert
        expect(
          res,
          equals(left(AuthFailure(message: tServerException.message))),
        );
        verify(() => mockAuthRemoteDatasource.signOut()).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDatasource);
      },
    );
  });
}
