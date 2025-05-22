import '../bloc/panier_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../produits/domain/entities/product.dart';
import '../../domain/entities/panier_item.dart';

class PanierItemWidget extends StatelessWidget {
  const PanierItemWidget({
    super.key,
    required this.panierItem,
  });

  final PanierItem panierItem;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      color: ColorScheme.of(context).surfaceContainer,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: _CardContent(panierItem: panierItem),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.panierItem,
  });

  final PanierItem panierItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductImage(product: panierItem.product),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProductDescriptif(product: panierItem.product),
                      Divider(),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            "${panierItem.product.price}€",
                            style: TextTheme.of(context).titleMedium,
                          ),
                          Spacer(),
                          Card.outlined(
                            color: ColorScheme.of(context).surfaceContainerHigh,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed:
                                      () => context.read<PanierBloc>().add(
                                        PanierUpdateItemQuantityEvent(
                                          itemId: panierItem.product.id,
                                          quantity: panierItem.quantity - 1,
                                        ),
                                      ),
                                  icon: Icon(Icons.remove),
                                ),
                                Text(panierItem.quantity.toString()),
                                IconButton(
                                  onPressed:
                                      () => context.read<PanierBloc>().add(
                                        PanierUpdateItemQuantityEvent(
                                          itemId: panierItem.product.id,
                                          quantity: panierItem.quantity + 1,
                                        ),
                                      ),
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed:
                              () => context.read<PanierBloc>().add(
                                PanierRemoveItemEvent(
                                  itemId: panierItem.product.id,
                                ),
                              ),
                          icon: Icon(Icons.remove_shopping_cart_outlined),
                          label: Text("Retirer du panier"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      color: ColorScheme.of(context).surfaceContainerHigh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [_ImageContainer(product: product)],
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({required this.product});

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

class _ProductDescriptif extends StatelessWidget {
  const _ProductDescriptif({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/produits/${product.id}'),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextTheme.of(context).titleMedium,
              ),
              _ProductDetails(product: product),
            ],
          ),
          Spacer(),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
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
        Builder(
          builder: (context) {
            if (product.category == null) {
              return Text(
                "Non catégorisé",
                style: TextTheme.of(context).labelSmall,
              );
            }
            return Text(
              product.category!.name,
              style: TextTheme.of(context).labelSmall,
            );
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
          product.degree != null ? "${product.degree}°" : "Inconnu",
          style: TextTheme.of(context).labelSmall,
        ),
      ],
    );
  }
}
