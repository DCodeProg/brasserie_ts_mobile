part of 'panier_bloc.dart';

sealed class PanierEvent extends Equatable {
  const PanierEvent();

  @override
  List<Object> get props => [];
}

final class PanierLoadPanierEvent extends PanierEvent {}

final class PanierAddItemEvent extends PanierEvent {
  final String itemId;
  final int quantite;

  const PanierAddItemEvent({required this.itemId, required this.quantite});

  @override
  List<Object> get props => [itemId, quantite];
}

final class PanierRemoveItemEvent extends PanierEvent {
  final String itemId;

  const PanierRemoveItemEvent({required this.itemId});

  @override
  List<Object> get props => [itemId];
}

final class PanierUpdateItemQuantityEvent extends PanierEvent {
  final String itemId;
  final int quantite;

  const PanierUpdateItemQuantityEvent({
    required this.itemId,
    required this.quantite,
  });

  @override
  List<Object> get props => [itemId, quantite];
}

final class PanierClearItemsEvent extends PanierEvent {}
