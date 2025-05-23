import 'package:equatable/equatable.dart';

import '../../../panier/domain/entities/panier.dart';

class Reservation extends Equatable {
  final int id;
  final String etat;
  final DateTime createdAt;
  final String clientUid;
  final Panier panier;

  const Reservation({
    required this.id,
    required this.etat,
    required this.createdAt,
    required this.clientUid,
    required this.panier,
  });

  @override
  List<Object?> get props => [
    id,
    etat,
    createdAt,
    clientUid,
    panier,
  ];
}
