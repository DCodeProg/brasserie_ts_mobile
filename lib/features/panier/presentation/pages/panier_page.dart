import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../produits/presentation/bloc/products_bloc.dart';
import '../bloc/panier_bloc.dart';

class PanierPage extends StatelessWidget {
  const PanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Panier", style: TextTheme.of(context).displaySmall),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, productState) {
          switch (productState) {
            case ProductsInitialState():
            case ProductsLoadingState():
            case ProductsFailureState():
              return Placeholder();
            case ProductsLoadedState():
              return BlocBuilder<PanierBloc, PanierState>(
                builder: (context, state) {
                  switch (state) {
                    case PanierLoadingState():
                      return Center(child: CircularProgressIndicator());
                    case PanierEmptyState():
                      return _PanierEmptyWidget();
                    case PanierLoadedState():
                      return Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.panier.panierItems.length,
                                itemBuilder: (context, index) {
                                  final produit =
                                      state.panier.panierItems[index];
                                  return ListTile(
                                    title: Text(produit.id),
                                    subtitle: Text(produit.quantite.toString()),
                                  );
                                },
                              ),
                            ),
                            FilledButton.icon(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                              },
                              label: Text("Réserver le panier"),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                context.read<PanierBloc>().add(
                                  PanierClearItemsEvent(),
                                );
                              },
                              child: Text("Vider le panier"),
                            ),
                          ],
                        ),
                      );
                    case PanierFailureState():
                      return Text("error: ${state.message}");
                  }
                },
              );
          }
        },
      ),
    );
  }
}

class _PanierEmptyWidget extends StatelessWidget {
  const _PanierEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.production_quantity_limits,
              size: 50,
              color: ColorScheme.of(context).primary,
            ),
            SizedBox(height: 16),
            Text(
              "Votre panier est vide",
              style: TextTheme.of(context).labelLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                HapticFeedback.selectionClick();
                context.goNamed("produits");
              },
              icon: Icon(Icons.shopping_bag_outlined),
              label: Text("Commencer votre shopping"),
            ),
          ],
        ),
      ),
    );
  }
}
