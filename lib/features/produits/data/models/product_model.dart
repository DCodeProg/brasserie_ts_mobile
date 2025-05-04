import 'dart:convert';

import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.nom,
    required super.description,
    required super.prix,
    required super.categorieId,
    required super.imageUrl,
    required super.volume,
    required super.degre,
    required super.quantite,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': nom,
      'description': description,
      'prix': prix,
      'categorie': categorieId,
      'image_url': imageUrl,
      'volume': volume,
      'degre': degre,
      'quantite': degre,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      nom: map['nom'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      prix: (map['prix'] as num).toDouble(),
      categorieId: map['categorie'] != null ? map['categorie'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      volume: (map['volume'] as num).toDouble(),
      degre: map['degre'] != null ? (map['degre'] as num).toDouble() : null,
      quantite: map['quantite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
