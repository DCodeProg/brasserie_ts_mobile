import 'package:equatable/equatable.dart';

import '../../../categories/domain/entities/category.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double price;
  final Category? category;
  final String? imageUrl;
  final double volume;
  final double? degree;
  final int quantity;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.volume,
    required this.degree,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    category,
    imageUrl,
    volume,
    degree,
    quantity,
  ];
}
