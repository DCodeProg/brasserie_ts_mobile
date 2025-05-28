part of 'panier_bloc.dart';

sealed class PanierEvent extends Equatable {
  const PanierEvent();

  @override
  List<Object> get props => [];
}

final class PanierLoadPanierEvent extends PanierEvent {}

final class PanierAddItemEvent extends PanierEvent {
  final Product product;
  final int quantity;

  const PanierAddItemEvent({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];
}

final class PanierRemoveItemEvent extends PanierEvent {
  final String itemId;

  const PanierRemoveItemEvent({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

final class PanierUpdateItemQuantityEvent extends PanierEvent {
  final String itemId;
  final int quantity;

  const PanierUpdateItemQuantityEvent({
    required this.itemId,
    required this.quantity,
  });

  @override
  List<Object> get props => [itemId, quantity];
}

final class PanierClearItemsEvent extends PanierEvent {}
