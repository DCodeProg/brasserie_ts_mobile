import 'package:brasserie_ts_mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:brasserie_ts_mobile/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGotrueClient extends Mock implements GoTrueClient {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockUser extends Mock implements User {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder extends Mock
    implements PostgrestFilterBuilder<PostgrestList> {}

class MockPostgrestTransformBuilder extends Mock
    implements PostgrestTransformBuilder<PostgrestList> {}

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGotrueClient mockGotrueClient;
  late MockAuthResponse mockAuthResponse;
  late MockUser mockUser;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late MockPostgrestFilterBuilder mockPostgrestFilterBuilder;
  late MockPostgrestTransformBuilder mockPostgrestTransformBuilder;
  late AuthRemoteDatasourceImplt authRemoteDatasourceImpl;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGotrueClient = MockGotrueClient();
    mockAuthResponse = MockAuthResponse();
    mockUser = MockUser();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();
    mockPostgrestTransformBuilder = MockPostgrestTransformBuilder();
    authRemoteDatasourceImpl = AuthRemoteDatasourceImplt(
      supabaseClient: mockSupabaseClient,
    );

    when(() => mockSupabaseClient.auth).thenReturn(mockGotrueClient);
  });

  final String tUid = "21ff33c1-3087-4a80-89f1-c911eeed22bf";
  final String tEmail = "john.doe@host-dcode.fr";
  final String tPassword = "J0hnD03!*21";
  final String tNom = "Doe";
  final String tPrenom = "John";
  final DateTime tCreatedAt = DateTime.now();

  final tUser = UserModel(
    uid: tUid,
    email: tEmail,
    nom: tNom,
    prenom: tPrenom,
    createdAt: tCreatedAt,
  );

  group("signInWithPassword", () {
    test("should return a UserModel when the sign-in is successful", () {
      // arrange
      when(
        () => mockGotrueClient.signInWithPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => mockAuthResponse);
      when(() => mockAuthResponse.user).thenReturn(mockUser);
      when(() => mockUser.id).thenReturn(tUid);
      when(() => mockUser.email).thenReturn(tEmail);

      when(
        () => mockSupabaseClient.from('utilisateurs').select(),
      ).thenReturn(mockPostgrestFilterBuilder);

      when(
        () => mockPostgrestFilterBuilder.select(),
      ).thenReturn(mockPostgrestTransformBuilder);
    });
  });

  group("signUp", () {});
}
