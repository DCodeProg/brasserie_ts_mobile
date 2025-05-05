import 'package:equatable/equatable.dart';

class PannierItem extends Equatable {
  final String id;
  final int quantite;

  const PannierItem({required this.id, required this.quantite});

  @override
  List<Object?> get props => [id, quantite];
}
