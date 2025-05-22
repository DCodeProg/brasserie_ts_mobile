import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../produits/domain/entities/product.dart';
import '../../domain/entities/panier.dart';
import '../../domain/usecases/add_item.dart';
import '../../domain/usecases/clear_items.dart';
import '../../domain/usecases/load_panier.dart';
import '../../domain/usecases/remove_item.dart';
import '../../domain/usecases/update_item_quantity.dart';

part 'panier_event.dart';
part 'panier_state.dart';

class PanierBloc extends Bloc<PanierEvent, PanierState> {
  final AddItem addItem;
  final ClearItems clearItems;
  final LoadPanier loadPanier;
  final RemoveItem removeItem;
  final UpdateItemQuantity updateItemQuantity;

  PanierBloc({
    required this.addItem,
    required this.clearItems,
    required this.loadPanier,
    required this.removeItem,
    required this.updateItemQuantity,
  }) : super(PanierEmptyState()) {
    on<PanierLoadPanierEvent>(
      (event, emit) => _onLoadPanierEvent(event, emit),
    );
    on<PanierAddItemEvent>(
      (event, emit) => _onAddItemEvent(event, emit),
    );
    on<PanierClearItemsEvent>(
      (event, emit) => _onClearItemsEvent(event, emit),
    );
    on<PanierRemoveItemEvent>(
      (event, emit) => _onRemoveItemEvent(event, emit),
    );
    on<PanierUpdateItemQuantityEvent>(
      (event, emit) => _onUpdateItemQuantityEvent(event, emit),
    );

    add(PanierLoadPanierEvent());
  }

  Future<void> _onAddItemEvent(PanierAddItemEvent event, Emitter emit) async {
    emit(PanierLoadingState());

    final res = await addItem(
      AddItemParams(
        product: event.product,
        quantity: event.quantity,
      ),
    );

    res.fold(
      (l) {
        Aptabase.instance.trackEvent("panier_item_add_failed", {
          "item_id": event.product.id,
          "quantity": event.quantity,
          "error": l.message,
        });
        emit(PanierFailureState(message: l.message));
      },
      (r) {
        Aptabase.instance.trackEvent("panier_item_added", {
          "item_id": event.product.id,
          "quantity": event.quantity,
        });
        _emitPanier(r, emit);
      },
    );
  }

  Future<void> _onClearItemsEvent(
    PanierClearItemsEvent event,
    Emitter emit,
  ) async {
    emit(PanierLoadingState());

    final res = await clearItems();

    res.fold(
      (l) {
        Aptabase.instance.trackEvent("panier_clear_failed", {
          "error": l.message,
        });
        emit(PanierFailureState(message: l.message));
      },
      (r) {
        Aptabase.instance.trackEvent("panier_cleared");
        _emitPanier(r, emit);
      },
    );
  }

  Future<void> _onLoadPanierEvent(
    PanierLoadPanierEvent event,
    Emitter emit,
  ) async {
    emit(PanierLoadingState());

    final res = await loadPanier();

    res.fold(
      (l) => emit(PanierFailureState(message: l.message)),
      (r) => _emitPanier(r, emit),
    );
  }

  Future<void> _onRemoveItemEvent(
    PanierRemoveItemEvent event,
    Emitter emit,
  ) async {
    emit(PanierLoadingState());

    final res = await removeItem(RemoveItemParams(itemId: event.itemId));

    res.fold(
      (l) {
        Aptabase.instance.trackEvent("panier_item_remove_failed", {
          "item_id": event.itemId,
          "error": l.message,
        });
        emit(PanierFailureState(message: l.message));
      },
      (r) {
        Aptabase.instance.trackEvent("panier_item_removed", {
          "item_id": event.itemId,
        });
        _emitPanier(r, emit);
      },
    );
  }

  Future<void> _onUpdateItemQuantityEvent(
    PanierUpdateItemQuantityEvent event,
    Emitter emit,
  ) async {
    final res = await updateItemQuantity(
      UpdateQuantityParams(
        itemId: event.itemId,
        quantity: event.quantity,
      ),
    );

    res.fold(
      (l) => emit(PanierFailureState(message: l.message)),
      (r) => _emitPanier(r, emit),
    );
  }

  void _emitPanier(Panier panier, Emitter emit) {
    if (panier.panierItems.isNotEmpty) {
      emit(PanierLoadedState(panier: panier));
    } else {
      emit(PanierEmptyState());
    }
  }
}
