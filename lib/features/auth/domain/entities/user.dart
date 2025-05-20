import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String nom;
  final String prenom;
  final DateTime createdAt;

  const User({
    required this.uid,
    required this.email,
    required this.nom,
    required this.prenom,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    nom,
    prenom,
    createdAt,
  ];
}
