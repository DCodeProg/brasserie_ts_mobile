import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final int id;
  final String etat;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String clientUid;

  const Reservation({
    required this.id,
    required this.etat,
    required this.updatedAt,
    required this.createdAt,
    required this.clientUid,
  });

  @override
  List<Object?> get props => [
    id,
    etat,
    updatedAt,
    createdAt,
    clientUid,
  ];
}
