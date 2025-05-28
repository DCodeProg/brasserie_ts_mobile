import 'package:equatable/equatable.dart';

import 'panier_item.dart';

class Panier extends Equatable {
  final List<PanierItem> panierItems;

  const Panier({
    required this.panierItems,
  });

  @override
  List<Object?> get props => [
    panierItems,
  ];
}
