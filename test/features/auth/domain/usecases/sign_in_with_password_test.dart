import 'package:brasserie_ts_mobile/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:brasserie_ts_mobile/features/auth/domain/entities/user.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/usecases/sign_in_with_password.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithPassword signInWithPassword;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithPassword = SignInWithPassword(mockAuthRepository);
  });

  final String tEmail = "john.doe@host-dcode.fr";
  final String tPassword = "J0hnD03!*21";

  final tUser = User(
    uid: "21ff33c1-3087-4a80-89f1-c911eeed22bf",
    email: tEmail,
    nom: "Doe",
    prenom: "John",
    dateNaissance: DateTime(2000, 01, 01),
    createdAt: DateTime(2025, 03, 04, 14, 53, 12),
  );

  test("should return a User from the repository", () async {
    // arrange
    when(
      () => mockAuthRepository.signInWithPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).thenAnswer((_) async => Right(tUser));

    // act
    final res = await signInWithPassword(
      SignInWithPasswordParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(res, equals(Right(tUser)));
    verify(
      () => mockAuthRepository.signInWithPassword(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test(
    "should return a Failure from the repository when an error occured",
    () async {
      // arrange
      final tFailure = ServerFailure(message: "auth error");
      when(
        () => mockAuthRepository.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => Left(tFailure));

      // act
      final res = await signInWithPassword(
        SignInWithPasswordParams(email: tEmail, password: tPassword),
      );

      // assert
      expect(res, equals(Left(tFailure)));
      verify(
        () => mockAuthRepository.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
