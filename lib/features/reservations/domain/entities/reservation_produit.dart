import 'package:equatable/equatable.dart';

class ReservationProduit extends Equatable {
  final String produitId;
  final int quantite;

  const ReservationProduit({required this.produitId, required this.quantite});

  @override
  List<Object?> get props => [produitId, quantite];
}
