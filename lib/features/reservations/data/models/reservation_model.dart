import 'dart:convert';

import 'package:brasserie_ts_mobile/features/panier/data/models/panier_model.dart';

import '../../domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.etat,
    required super.createdAt,
    required super.clientUid,
    required super.panier,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'etat': etat,
      'created_at': createdAt.toIso8601String(),
      'client_uid': clientUid,
      // Ajoute le panier si besoin
      'reservation_produits': (panier as PanierModel).toMap()['produits'],
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id'] as int,
      etat: map['etat'] as String,
      createdAt: DateTime.parse(map['created_at']),
      clientUid: map['client_uid'] ?? "",
      panier: PanierModel.fromMap({
        'panierItems':
            (map['reservation_produits'] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ??
            [],
      }),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
