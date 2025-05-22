import 'dart:convert';

import '../../domain/entities/panier.dart';
import '../../domain/entities/panier_item.dart';
import 'panier_item_model.dart';

class PanierModel extends Panier {
  const PanierModel({required super.panierItems});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'panierItems':
          panierItems
              .map(
                (item) =>
                    PanierItemModel(
                      product: item.product,
                      quantity: item.quantity,
                    ).toMap(),
              )
              .toList(),
    };
  }

  factory PanierModel.fromMap(Map<String, dynamic> map) {
    return PanierModel(
      panierItems: List<PanierItem>.from(
        map['panierItems'].map<PanierItem>(
          (item) => PanierItemModel.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PanierModel.fromJson(String source) =>
      PanierModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PanierModel copyWith({List<PanierItem>? panierItems}) {
    return PanierModel(panierItems: panierItems ?? this.panierItems);
  }
}
