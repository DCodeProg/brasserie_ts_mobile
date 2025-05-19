import 'package:flutter_test/flutter_test.dart';

import 'package:brasserie_ts_mobile/features/auth/data/models/user_model.dart';

import '../../../../fixtures/fixtures_helper.dart';

void main() {
  final String tUid = "21ff33c1-3087-4a80-89f1-c911eeed22bf";
  final String tEmail = "john.doe@host-dcode.fr";
  final String tNom = "Doe";
  final String tPrenom = "John";
  final DateTime tCreatedAt = DateTime.parse("2025-04-26T17:53:19.857");

  final tUserModel = UserModel(
    uid: tUid,
    email: tEmail,
    nom: tNom,
    prenom: tPrenom,
    createdAt: tCreatedAt,
  );

  final tMap = {
    'uid': tUid,
    'email': tEmail,
    'nom': tNom,
    'prenom': tPrenom,
    'createdAt': "2025-04-26T17:53:19.857",
  };

  group("toMap", () {
    test("should return a map with the correct user data", () {
      // act
      final userMap = tUserModel.toMap();

      // assert
      expect(userMap, equals(tMap));
    });
  });

  group("fromMap", () {
    test("should return a UserModel when created from a map", () {
      // act
      final userModel = UserModel.fromMap(tMap);

      // assert
      expect(userModel, isA<UserModel>());
    });

    test("should have correct data when created from a map", () {
      // act
      final userModel = UserModel.fromMap(tMap);

      // assert
      expect(userModel.uid, equals(tUid));
      expect(userModel.email, equals(tEmail));
      expect(userModel.nom, equals(tNom));
      expect(userModel.prenom, equals(tPrenom));
      expect(
        userModel.createdAt,
        equals(tCreatedAt),
      );
    });
  });

  group("toJson", () {
    test("should return a json with the correct user data", () {
      // arrange
      final tExpectedJson = FixturesHelper.readFixture("auth/user_model.json");
      final tNormalizedExpectedJson = FixturesHelper.normalizeJson(
        tExpectedJson,
      );

      // act
      final tUserJson = tUserModel.toJson();
      final tNormalizedUserJson = FixturesHelper.normalizeJson(tUserJson);

      // assert
      expect(tNormalizedUserJson, tNormalizedExpectedJson);
    });
  });

  group("fromJson", () {
    test("should return a UserModel when created from a json", () {
      // arrange
      final tJson = FixturesHelper.readFixture("auth/user_model.json");

      // act
      final tUserFromJson = UserModel.fromJson(tJson);

      // assert
      expect(tUserFromJson, isA<UserModel>());
    });

    test("should have correct data when created from json", () {
      // arrange
      final tJson = FixturesHelper.readFixture("auth/user_model.json");

      // act
      final tUserFromJson = UserModel.fromJson(tJson);

      // assert
      expect(tUserFromJson.uid, tUid);
      expect(tUserFromJson.email, tEmail);
      expect(tUserFromJson.nom, tNom);
      expect(tUserFromJson.prenom, tPrenom);
      expect(tUserFromJson.createdAt, tCreatedAt);
    });
  });

  group("copyWith", () {
    test("should return a UserModel when copied with some change", () {
      // arrange
      final String tEditedNom = "Johny";

      // act
      final tCopiedUser = tUserModel.copyWith(
        nom: tEditedNom,
      );

      // assert
      expect(tCopiedUser, isA<UserModel>());
    });

    test("should have correct data when copied with some change", () {
      // arrange
      final String tEditedNom = "Johny";

      // act
      final tCopiedUser = tUserModel.copyWith(
        nom: tEditedNom,
      );

      // assert
      expect(tCopiedUser.uid, tUid);
      expect(tCopiedUser.email, tEmail);
      expect(tCopiedUser.nom, tEditedNom);
      expect(tCopiedUser.prenom, tPrenom);
      expect(tCopiedUser.createdAt, tCreatedAt);
    });
  });
}
