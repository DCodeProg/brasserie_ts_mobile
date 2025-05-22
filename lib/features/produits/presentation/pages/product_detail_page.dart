import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../panier/presentation/bloc/panier_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.produitId});

  final String? produitId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Détails du produit")),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            switch (state) {
              case ProductsLoadingState():
                return _ProductLoading();

              case ProductsInitialState():
              case ProductsFailureState():
                // TODO: Return to main page with snackbar
                return Placeholder();

              case ProductsLoadedState():
                if (produitId == null) {
                  return Placeholder();
                }
                final Product? product = context
                    .read<ProductsBloc>()
                    .getProductById(produitId!);
                if (product != null) {
                  return _ProductDetailsWidget(product: product);
                } else {
                  return Placeholder();
                }
            }
          },
        ),
      ),
    );
  }
}

class _ProductDetailsWidget extends StatelessWidget {
  const _ProductDetailsWidget({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: 350),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, top: 8, right: 16),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: ColorScheme.of(context).surfaceContainerHigh,
                  ),
                  child:
                      product.imageUrl != null
                          ? CachedNetworkImage(
                            imageUrl: product.imageUrl!,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                          )
                          : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.liquor, size: 100),
                          ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextTheme.of(context).headlineSmall,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.category_outlined, size: 15),
                          SizedBox(width: 4),
                          Builder(
                            builder: (context) {
                              if (product.category == null) {
                                return Text(
                                  "Non catégorisé",
                                  style: TextTheme.of(
                                    context,
                                  ).labelMedium?.copyWith(
                                    color:
                                        ColorScheme.of(
                                          context,
                                        ).onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                );
                              }
                              return Text(
                                product.category!.name,
                                style: TextTheme.of(context).labelMedium,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        spacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_drink_outlined, size: 15),
                              SizedBox(width: 4),
                              Text(
                                "${product.volume}L",
                                style: TextTheme.of(context).labelMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.thermostat, size: 15),
                              SizedBox(width: 4),
                              Text(
                                product.degree != null
                                    ? "${product.degree}°"
                                    : "Inconnu",
                                style: TextTheme.of(context).labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Description",
                        style: TextTheme.of(context).titleMedium?.copyWith(
                          color: ColorScheme.of(context).secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.description ??
                            "Ce produit n'a pas de description",
                        style: TextTheme.of(context).bodyMedium?.copyWith(
                          color: ColorScheme.of(context).onSurfaceVariant,
                          fontStyle:
                              product.description == null
                                  ? FontStyle.italic
                                  : null,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        _AddToCartWidget(product: product),
      ],
    );
  }
}

class _AddToCartWidget extends StatelessWidget {
  const _AddToCartWidget({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: ColorScheme.of(context).surfaceContainerHighest,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.price.toStringAsFixed(2)} €",
                    style: TextTheme.of(context).headlineSmall,
                  ),
                  Builder(
                    builder: (context) {
                      if (product.quantity >= 10) {
                        return Text(
                          "En stock",
                          style: TextTheme.of(context).labelMedium?.copyWith(
                            color: ColorScheme.of(context).tertiary,
                          ),
                        );
                      } else if (product.quantity > 0) {
                        return Text(
                          "${product.quantity} restant(s)",
                          style: TextTheme.of(context).labelMedium?.copyWith(
                            color: ColorScheme.of(context).error,
                          ),
                        );
                      } else {
                        return Text(
                          "En rupture de stock",
                          style: TextTheme.of(context).labelMedium?.copyWith(
                            color: ColorScheme.of(context).error,
                            fontStyle: FontStyle.italic,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              Spacer(),
              // Card.outlined(
              //   color: ColorScheme.of(context).surfaceContainerHighest,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
              //       Text("1", style: TextTheme.of(context).titleMedium),
              //       IconButton(onPressed: () {}, icon: Icon(Icons.add)),
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          AddToCartButton(product: product),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({super.key, required this.product});

  final Product product;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _animation = false;
  Future<void> _addToCart() async {
    if (!_animation) {
      context.read<PanierBloc>().add(
        PanierAddItemEvent(
          product: widget.product,
          quantity: 1,
        ),
      );
      setState(() {
        _animation = true;
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _animation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _addToCart,
        icon: Icon(
          _animation ? Icons.shopping_cart_checkout : Icons.add_shopping_cart,
        ),
        label: Text(_animation ? "Ajouté !" : "Ajouter au panier"),
      ),
    );
  }
}

class _ProductLoading extends StatelessWidget {
  const _ProductLoading();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
