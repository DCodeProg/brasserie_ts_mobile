import 'dart:convert';

import '../../domain/entities/panier_item.dart';

class PanierItemModel extends PanierItem {
  const PanierItemModel({required super.id, required super.quantite});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantite': quantite,
    };
  }

  factory PanierItemModel.fromMap(Map<String, dynamic> map) {
    return PanierItemModel(
      id: map['id'] as String,
      quantite: map['quantite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PanierItemModel.fromJson(String source) => PanierItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PanierItemModel copyWith({
    String? id,
    int? quantite,
  }) {
    return PanierItemModel(
      id: id ?? this.id,
      quantite: quantite ?? this.quantite,
    );
  }
}
