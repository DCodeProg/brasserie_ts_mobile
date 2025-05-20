import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.email,
    required super.nom,
    required super.prenom,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? nom,
    String? prenom,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
