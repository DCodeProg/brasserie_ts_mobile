import 'package:equatable/equatable.dart';

import 'pannier_item.dart';

class Pannier extends Equatable {
  final List<PannierItem> pannierItems;

  const Pannier({required this.pannierItems});

  @override
  List<Object?> get props => [pannierItems];
}
