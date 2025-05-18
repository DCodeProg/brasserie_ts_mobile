import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:brasserie_ts_mobile/core/errors/failures.dart';
import 'package:brasserie_ts_mobile/core/usecase/usecase.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/entities/user.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/usecases/get_current_user.dart';
import 'package:brasserie_ts_mobile/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCurrentUser getCurrentUser;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getCurrentUser = GetCurrentUser(authRepository: mockAuthRepository);
  });

  final tUser = User(
    uid: "21ff33c1-3087-4a80-89f1-c911eeed22bf",
    email: "john.doe@host-dcode.fr",
    nom: "Doe",
    prenom: "John",
    createdAt: DateTime(2025, 03, 04, 14, 53, 12),
  );

  test("should return a User from from the repository", () async {
    // arrange
    when(
      () => mockAuthRepository.getCurrentUser(),
    ).thenAnswer((_) async => right(tUser));

    // act
    final res = await getCurrentUser(NoParams());

    // assert
    expect(res, equals(right(tUser)));
    verify(() => mockAuthRepository.getCurrentUser()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test(
    "should return a Failure from the repository when an error occured",
    () async {
      // arrange
      final tAuthFailure = AuthFailure(message: "an error occured");
      when(
        () => mockAuthRepository.getCurrentUser(),
      ).thenAnswer((_) async => left(tAuthFailure));

      // act
      final res = await getCurrentUser(NoParams());

      // assert
      expect(res, equals(left(tAuthFailure)));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
