import 'package:flutter/material.dart';
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
            icon: Icon(Icons.liquor),
            label: "Produits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Compte",
          ),
        ],
      ),
    );
  }
}
