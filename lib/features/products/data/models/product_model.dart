import 'dart:convert';

import '../../../categories/data/models/category_model.dart';
import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.category,
    required super.imageUrl,
    required super.volume,
    required super.degree,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nom': name,
      'description': description,
      'prix': price,
      'categorie':
          category != null ? CategoryModel.fromEntity(category!).toMap() : null,
      'image_url': imageUrl,
      'volume': volume,
      'degre': degree,
      'quantite': quantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['nom'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: (map['prix'] as num).toDouble(),
      category:
          map['categorie'] != null
              ? CategoryModel.fromMap(map['categorie'] as Map<String, dynamic>)
              : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
      volume: (map['volume'] as num).toDouble(),
      degree: map['degre'] != null ? (map['degre'] as num).toDouble() : null,
      quantity: map['quantite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) {
    return ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      category:
          product.category != null
              ? CategoryModel.fromEntity(product.category!)
              : null,
      imageUrl: product.imageUrl,
      volume: product.volume,
      degree: product.degree,
      quantity: product.quantity,
    );
  }
}
