import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String nom;
  final String? description;

  const Category({
    required this.id,
    required this.nom,
    required this.description,
  });

  @override
  List<Object?> get props => [id, nom, description];
}
