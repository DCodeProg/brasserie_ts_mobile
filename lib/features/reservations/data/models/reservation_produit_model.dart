import 'dart:convert';

import 'package:brasserie_ts_mobile/features/reservations/domain/entities/reservation_produit.dart';

class ReservationProduitModel extends ReservationProduit {
  const ReservationProduitModel({
    required super.produitId,
    required super.quantite,
  });

  Map<String, dynamic> toMap() {
    return {
      'produitId': produitId,
      'quantite': quantite,
    };
  }

  factory ReservationProduitModel.fromMap(Map<String, dynamic> map) {
    return ReservationProduitModel(
      produitId: map['produitId'] as String,
      quantite: map['quantite'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationProduitModel.fromJson(String source) =>
      ReservationProduitModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
