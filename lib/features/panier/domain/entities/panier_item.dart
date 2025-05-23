import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';

class PanierItem extends Equatable {
  final Product product;
  final int quantity;

  const PanierItem({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
    product,
    quantity,
  ];
}
