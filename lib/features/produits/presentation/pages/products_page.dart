import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../categories/presentation/bloc/categories_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';
import '../widgets/product_list_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produits", style: TextTheme.of(context).displaySmall),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state) {
            case ProductsInitialState():
            case ProductsLoadingState():
              return _ProductsLoadingWidget();
            case ProductsLoadedState():
              return _ProductListWidget(products: state.products);
            case ProductsFailureState():
              return _ProductFailureWidget(message: state.message);
          }
        },
      ),
    );
  }
}

class _ProductListWidget extends StatelessWidget {
  const _ProductListWidget({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    void refreshProducts() {
      HapticFeedback.selectionClick();
      context.read<ProductsBloc>().add(ProductsFetchAllProductsEvent());
    }

    if (products.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<ProductsBloc>().add(ProductsFetchAllProductsEvent());
          context.read<CategoriesBloc>().add(
            CategoriesFetchAllCategoriesEvent(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16  ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final Product product = products[index];
              return ProductListItem(product: product);
            },
            // separatorBuilder: (context, index) => Divider(height: 0),
          ),
        ),
      );
    } else {
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
                "Aucun produit disponible",
                style: TextTheme.of(context).labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              FilledButton.icon(
                onPressed: refreshProducts,
                icon: Icon(Icons.refresh),
                label: Text("Recharger"),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class _ProductFailureWidget extends StatelessWidget {
  const _ProductFailureWidget({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    void refreshProducts() {
      HapticFeedback.selectionClick();
      context.read<ProductsBloc>().add(ProductsFetchAllProductsEvent());
    }

    void showErrorMessageDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Détails de l'erreur"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: message));
                },
                child: Text("Copier"),
              ),
              TextButton(onPressed: () => context.pop(), child: Text("Fermer")),
            ],
          );
        },
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              Icons.error_outline,
              size: 50,
              color: ColorScheme.of(context).error,
            ),
            SizedBox(height: 16),
            Text(
              "Une erreur est survenue lors du chargement des produits !",
              style: TextTheme.of(
                context,
              ).labelLarge?.copyWith(color: ColorScheme.of(context).error),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            FilledButton.icon(
              onPressed: refreshProducts,
              icon: Icon(Icons.refresh),
              label: Text("Recharger"),
            ),
            Spacer(),
            TextButton.icon(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(
                  ColorScheme.of(context).tertiary,
                ),
                textStyle: WidgetStatePropertyAll(
                  TextTheme.of(context).labelSmall,
                ),
                iconSize: WidgetStatePropertyAll(10),
              ),
              onPressed: showErrorMessageDialog,
              icon: Icon(Icons.info_outline),
              label: Text("Détails de l'erreur"),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsLoadingWidget extends StatelessWidget {
  const _ProductsLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              "Chargement des produits en cours",
              style: TextTheme.of(context).labelLarge?.copyWith(
                color: ColorScheme.of(context).onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
