import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/bloc/categories_bloc.dart';
import '../../../panier/presentation/bloc/panier_bloc.dart';
import '../../domain/entities/product.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    void openProductDetailPage() {
      HapticFeedback.selectionClick();
      context.push("/produits/${product.id}");
    }

    return Card.outlined(
      color: ColorScheme.of(context).surfaceContainer,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: openProductDetailPage,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    color: ColorScheme.of(context).surfaceContainerHigh,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [_ProductImage(product: product)],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.nom,
                            style: TextTheme.of(context).titleMedium,
                          ),
                          _ProductDetails(product: product),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          product.imageUrl != null
              ? CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: product.imageUrl!,
                progressIndicatorBuilder:
                    (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
              )
              : Icon(Icons.liquor, size: 40),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    void addToCart() {
      context.read<PanierBloc>().add(
        PanierAddItemEvent(itemId: product.id, quantite: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${product.nom} ajouté au panier"),
          duration: Durations.extralong1,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProductCategory(product: product),
        Wrap(
          spacing: 8,
          children: [
            _ProductVolume(product: product),
            _ProductDegre(product: product),
          ],
        ),
        SizedBox(height: 4),
        _ProductDescription(product: product),
        SizedBox(height: 8),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductPrice(product: product),
                _StockIndicator(product: product),
              ],
            ),
            Spacer(),
            IconButton.filled(
              iconSize: 20,
              visualDensity: VisualDensity(horizontal: -2, vertical: -2),
              onPressed: product.quantite > 0 ? addToCart : null,
              icon: Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProductCategory extends StatelessWidget {
  const _ProductCategory({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.category_outlined, size: 12),
        SizedBox(width: 4),
        BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            switch (state) {
              case CategoriesLoadedState():
                if (product.categorieId == null) {
                  return Text(
                    "Non catégorisé",
                    style: TextTheme.of(context).labelSmall?.copyWith(
                      color: ColorScheme.of(context).onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  );
                }

                final Category? category = context
                    .read<CategoriesBloc>()
                    .getCategoryById(product.categorieId!);

                return Text(
                  category != null ? category.nom : "Autres",
                  style: TextTheme.of(context).labelSmall,
                );

              case _:
                return Text(
                  "Indisponible",
                  style: TextTheme.of(context).labelSmall?.copyWith(
                    color: ColorScheme.of(context).error,
                    fontStyle: FontStyle.italic,
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}

class _ProductVolume extends StatelessWidget {
  const _ProductVolume({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_drink_outlined, size: 12),
        SizedBox(width: 4),
        Text("${product.volume}L", style: TextTheme.of(context).labelSmall),
      ],
    );
  }
}

class _ProductDegre extends StatelessWidget {
  const _ProductDegre({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.thermostat, size: 12),
        SizedBox(width: 4),
        Text(
          product.degre != null ? "${product.degre}°" : "Inconnu",
          style: TextTheme.of(context).labelSmall,
        ),
      ],
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text(
      product.description ?? "Ce produit n'a pas de description",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextTheme.of(context).bodySmall?.copyWith(
        fontStyle: product.description == null ? FontStyle.italic : null,
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text("${product.prix.toStringAsFixed(2)}€", style: TextTheme.of(context).titleMedium);
  }
}

class _StockIndicator extends StatelessWidget {
  const _StockIndicator({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.quantite >= 10) {
      return Text(
        "En stock",
        style: TextTheme.of(
          context,
        ).labelSmall?.copyWith(color: ColorScheme.of(context).tertiary),
      );
    } else if (product.quantite > 0) {
      return Text(
        "${product.quantite} restant(s)",
        style: TextTheme.of(
          context,
        ).labelSmall?.copyWith(color: ColorScheme.of(context).error),
      );
    } else {
      return Text(
        "En rupture de stock",
        style: TextTheme.of(context).labelSmall?.copyWith(
          color: ColorScheme.of(context).error,
          fontStyle: FontStyle.italic,
        ),
      );
    }
  }
}
