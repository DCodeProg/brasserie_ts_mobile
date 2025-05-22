import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/panier_bloc.dart';
import '../widgets/panier_item_widget.dart';

class PanierPage extends StatelessWidget {
  const PanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Panier",
          style: TextTheme.of(context).displaySmall,
        ),
        actions: [
          BlocBuilder<PanierBloc, PanierState>(
            builder: (context, state) {
              if (state is PanierLoadedState) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    color: ColorScheme.of(context).tertiaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total: ${(state.panier.panierItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity))).toStringAsFixed(2)}€",
                        style: TextTheme.of(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorScheme.of(context).onTertiaryContainer,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: BlocBuilder<PanierBloc, PanierState>(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          itemCount: state.panier.panierItems.length,
                          itemBuilder: (context, index) {
                            final panierItem = state.panier.panierItems[index];
                            return PanierItemWidget(panierItem: panierItem);
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorScheme.of(context).surfaceContainer,
                        border: Border(top: BorderSide(
                          color: ColorScheme.of(context).outlineVariant
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed:
                                    () => context.read<PanierBloc>().add(
                                      PanierClearItemsEvent(),
                                    ),
                                icon: Icon(Icons.shopping_cart_checkout),
                                label: Text("Réserver le panier"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            case PanierFailureState():
              return Column(
                children: [
                  Text("Le panier a rencontré une erreur: ${state.message}"),
                  ElevatedButton(
                    onPressed:
                        () => context.read<PanierBloc>().add(
                          PanierClearItemsEvent(),
                        ),
                    child: Text("Vider le panier"),
                  ),
                ],
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
