import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String nom;
  final String? description;
  final double prix;
  final String? categorieId;
  final String? imageUrl;
  final double volume;
  final double degre;

  const Product({
    required this.id,
    required this.nom,
    required this.description,
    required this.prix,
    required this.categorieId,
    required this.imageUrl,
    required this.volume,
    required this.degre,
  });

  @override
  List<Object?> get props => [
    id,
    nom,
    description,
    prix,
    categorieId,
    imageUrl,
    volume,
    degre,
  ];
}
