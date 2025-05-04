import 'package:go_router/go_router.dart';

import '../../features/produits/presentation/pages/product_detail_page.dart';
import '../../features/produits/presentation/pages/products_page.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", redirect: (context, state) => "/produits"),
    GoRoute(
      path: "/produits",
      name: "produits",
      builder: (context, state) => ProductsPage(),
    ),
    GoRoute(
      path: "/produits/:productId",
      builder: (context, state) => ProductDetailPage(produitId: state.pathParameters['productId'],),
    ),
  ],
);
