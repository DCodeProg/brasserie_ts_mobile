import 'dart:convert';

import 'package:brasserie_ts_mobile/features/reservations/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.etat,
    required super.updatedAt,
    required super.createdAt,
    required super.clientUid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'etat': etat,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'client_uid': clientUid,
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id'] as int,
      etat: map['etat'] as String,
      updatedAt: DateTime.parse(map['updated_at']),
      createdAt: DateTime.parse(map['created_at']),
      clientUid: map['client_uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
