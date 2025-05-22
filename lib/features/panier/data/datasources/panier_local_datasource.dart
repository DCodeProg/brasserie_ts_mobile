import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../produits/domain/entities/product.dart';
import '../../domain/entities/panier_item.dart';
import '../models/panier_model.dart';

abstract interface class PanierLocalDatasource {
  Future<PanierModel> addItem({
    required Product product,
    required int quantity,
  });
  Future<PanierModel> clearItems();
  Future<PanierModel> loadPanier();
  Future<PanierModel> removeItem({required String itemId});
  Future<PanierModel> updateItemQuantity({
    required String itemId,
    required int quantity,
  });
  Future<PanierItem?> checkProduit({required String itemId});
}

const cachedPanier = "CACHED_PANIER";

class PanierLocalDatasourceImpl implements PanierLocalDatasource {
  final SharedPreferences sharedPreferences;

  PanierLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<PanierModel> addItem({
    required Product product,
    required int quantity,
  }) async {
    final currentPanier = await loadPanier();

    final similarItem = await checkProduit(itemId: product.id);
    if (similarItem != null) {
      await updateItemQuantity(
        itemId: product.id,
        quantity: similarItem.quantity + quantity,
      );
      return await loadPanier();
    } else {
      final updatedPanier = currentPanier.copyWith(
        panierItems: [
          ...currentPanier.panierItems,
          PanierItem(product: product, quantity: quantity),
        ],
      );
      await sharedPreferences.setString(cachedPanier, updatedPanier.toJson());
      return updatedPanier;
    }
  }

  @override
  Future<PanierModel> clearItems() async {
    final emptyPanier = PanierModel(panierItems: []);
    await sharedPreferences.setString(cachedPanier, emptyPanier.toJson());
    return emptyPanier;
  }

  @override
  Future<PanierModel> loadPanier() async {
    final jsonString = sharedPreferences.getString(cachedPanier);
    if (jsonString != null) {
      return Future.value(PanierModel.fromJson(jsonString));
    } else {
      final emptyPanier = PanierModel(panierItems: []);
      await sharedPreferences.setString(cachedPanier, emptyPanier.toJson());
      return emptyPanier;
    }
  }

  @override
  Future<PanierModel> removeItem({required String itemId}) async {
    final currentPanier = await loadPanier();
    final updatedItems =
        currentPanier.panierItems
          ..removeWhere((item) => item.product.id == itemId);

    final updatedPanier = currentPanier.copyWith(panierItems: updatedItems);

    await sharedPreferences.setString(cachedPanier, updatedPanier.toJson());
    return updatedPanier;
  }

  @override
  Future<PanierModel> updateItemQuantity({
    required String itemId,
    required int quantity,
  }) async {
    final currentPanier = await loadPanier();
    final itemIndex = currentPanier.panierItems.indexWhere((item) => item.product.id == itemId);
    
    if (itemIndex == -1) {
      throw CacheException(message: "Item non trouvé dans le panier");
    }

    if (quantity <= 0) {
      return await removeItem(itemId: itemId);
    }

    final updatedItems = List<PanierItem>.from(currentPanier.panierItems);
    updatedItems[itemIndex] = PanierItem(
      product: currentPanier.panierItems[itemIndex].product,
      quantity: quantity
    );

    final updatedPanier = currentPanier.copyWith(panierItems: updatedItems);
    await sharedPreferences.setString(cachedPanier, updatedPanier.toJson());
    return updatedPanier;
  }

  @override
  Future<PanierItem?> checkProduit({required String itemId}) async {
    final currentPanier = await loadPanier();
    PanierItem? item =
        currentPanier.panierItems
            .where((item) => item.product.id == itemId)
            .firstOrNull;
    return item;
  }
}
