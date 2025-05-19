import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:brasserie_ts_mobile/core/errors/failures.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/entities/user.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/usecases/sign_up.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignUp signUp;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUp = SignUp(authRepository: mockAuthRepository);
  });

  final String tEmail = "john.doe@host-dcode.fr";
  final String tPassword = "J0hnD03!*21";
  final String tNom = "Doe";
  final String tPrenom = "John";
  final DateTime tCreatedAt = DateTime.now();

  final tUser = User(
    uid: "21ff33c1-3087-4a80-89f1-c911eeed22bf",
    email: tEmail,
    nom: tNom,
    prenom: tPrenom,
    createdAt: tCreatedAt,
  );

  test("should return a user from the repository", () async {
    // arrange
    when(
      () => mockAuthRepository.signUp(
        email: tEmail,
        password: tPassword,
        nom: tNom,
        prenom: tPrenom,
      ),
    ).thenAnswer((_) async => right(tUser));

    // act
    final res = await signUp(
      SignUpParams(
        email: tEmail,
        password: tPassword,
        nom: tNom,
        prenom: tPrenom,
      ),
    );

    // assert
    expect(res, equals(right(tUser)));
    verify(
      () => mockAuthRepository.signUp(
        email: tEmail,
        password: tPassword,
        nom: tNom,
        prenom: tPrenom,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test(
    "should return a Failure from the repository when an error occured",
    () async {
      // arrange
      final tFailure = ServerFailure(message: "register error");
      when(
        () => mockAuthRepository.signUp(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      ).thenAnswer((_) async => left(tFailure));

      // act
      final res = await signUp(
        SignUpParams(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      );

      // assert
      expect(res, equals(left(tFailure)));
      verify(
        () => mockAuthRepository.signUp(
          email: tEmail,
          password: tPassword,
          nom: tNom,
          prenom: tPrenom,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
