import 'package:brasserie_ts_mobile/core/errors/exceptions.dart';
import 'package:brasserie_ts_mobile/features/panier/domain/entities/panier_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/panier_model.dart';

abstract interface class PanierLocalDatasource {
  Future<PanierModel> addItem({required String itemId, required int quantite});
  Future<PanierModel> clearItems();
  Future<PanierModel> loadPanier();
  Future<PanierModel> removeItem({required String itemId});
  Future<PanierModel> updateItemQuantity({
    required String itemId,
    required int quantite,
  });
  Future<PanierItem?> checkProduit({required String itemId});
}

const cachedPanier = "CACHED_PANIER";

class PanierLocalDatasourceImpl implements PanierLocalDatasource {
  final SharedPreferences sharedPreferences;

  PanierLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<PanierModel> addItem({
    required String itemId,
    required int quantite,
  }) async {
    final currentPanier = await loadPanier();

    final similarItem = await checkProduit(itemId: itemId);
    if (similarItem != null) {
      await updateItemQuantity(
        itemId: itemId,
        quantite: similarItem.quantite + quantite,
      );
      return await loadPanier();
    } else {
      final updatedPanier = currentPanier.copyWith(
        panierItems: [
          ...currentPanier.panierItems,
          PanierItem(id: itemId, quantite: quantite),
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
        currentPanier.panierItems..removeWhere((item) => item.id == itemId);

    final updatedPanier = currentPanier.copyWith(panierItems: updatedItems);

    await sharedPreferences.setString(cachedPanier, updatedPanier.toJson());
    return updatedPanier;
  }

  @override
  Future<PanierModel> updateItemQuantity({
    required String itemId,
    required int quantite,
  }) async {
    if (await checkProduit(itemId: itemId) == null) {
      throw CacheException(message: "Item non trouvé dans le panier");
    }
    await removeItem(itemId: itemId);
    await addItem(itemId: itemId, quantite: quantite);
    return await loadPanier();
  }

  @override
  Future<PanierItem?> checkProduit({required String itemId}) async {
    final currentPanier = await loadPanier();
    PanierItem? item =
        currentPanier.panierItems
            .where((item) => item.id == itemId)
            .firstOrNull;
    return item;
  }
}
