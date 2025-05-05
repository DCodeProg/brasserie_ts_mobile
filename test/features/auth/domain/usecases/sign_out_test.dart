import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:brasserie_ts_mobile/core/errors/failures.dart';
import 'package:brasserie_ts_mobile/core/usecase/usecase.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/usecases/sign_out.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignOut signOut;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOut = SignOut(authRepository: mockAuthRepository);
  });

  test("should called signOut from the repository when called", () async {
    // arrange
    when(
      () => mockAuthRepository.signOut(),
      // ignore: void_checks
    ).thenAnswer((_) async => right(unit));

    // act
    final res = await signOut(NoParams());

    // assert
    expect(res, equals(right(unit)));
    verify(() => mockAuthRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test(
    "should return a failure from the repository when an error occured",
    () async {
      // arrange
      final tAuthFailure = AuthFailure(message: "an error occured");
      when(
        () => mockAuthRepository.signOut(),
      ).thenAnswer((_) async => left(tAuthFailure));

      // act
      final res = await signOut(NoParams());

      // assert
      expect(res, equals(left(tAuthFailure)));
      verify(() => mockAuthRepository.signOut()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
