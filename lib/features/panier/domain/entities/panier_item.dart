import 'package:equatable/equatable.dart';

class PanierItem extends Equatable {
  final String id;
  final int quantite;

  const PanierItem({required this.id, required this.quantite});

  @override
  List<Object?> get props => [id, quantite];
}
