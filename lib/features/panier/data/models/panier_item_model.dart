import 'dart:convert';

import '../../../produits/data/models/product_model.dart';

import '../../domain/entities/panier_item.dart';

class PanierItemModel extends PanierItem {
  const PanierItemModel({
    required super.product,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produit': ProductModel.fromEntity(product).toMap(),
      'quantite': quantity,
    };
  }

  factory PanierItemModel.fromMap(Map<String, dynamic> map) {
    return PanierItemModel(
      product: ProductModel.fromMap(map['produit'] as Map<String, dynamic>),
      quantity: map['quantite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PanierItemModel.fromJson(String source) =>
      PanierItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PanierItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return PanierItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
