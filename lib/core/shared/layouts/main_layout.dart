import 'package:brasserie_ts_mobile/features/panier/presentation/bloc/panier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap:
            (value) => navigationShell.goBranch(
              value,
              initialLocation: value == navigationShell.currentIndex,
            ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.liquor_outlined),
            activeIcon: Icon(Icons.liquor),
            label: "Produits",
          ),
          BottomNavigationBarItem(
            icon: _PanierBadgeIcon(iconData: Icons.shopping_cart_outlined),
            activeIcon: _PanierBadgeIcon(iconData: Icons.shopping_cart),
            label: "Panier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: "Compte",
          ),
        ],
      ),
    );
  }
}

class _PanierBadgeIcon extends StatelessWidget {
  const _PanierBadgeIcon({required this.iconData});

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PanierBloc, PanierState>(
      builder: (context, state) {
        if (state is PanierLoadedState) {
          if (state.panier.panierItems.isNotEmpty) {
            return Badge(
              label: Text(state.panier.panierItems.length.toString()),
              child: Icon(iconData),
            );
          } else {
            return Icon(iconData);
          }
        }
        return Icon(iconData);
      },
    );
  }
}
