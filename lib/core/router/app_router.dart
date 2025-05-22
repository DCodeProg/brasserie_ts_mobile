import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/my_informations_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/panier/presentation/pages/panier_page.dart';
import '../../features/produits/presentation/pages/product_detail_page.dart';
import '../../features/produits/presentation/pages/products_page.dart';
import '../shared/layouts/main_layout.dart';
import '../shared/pages/account_page.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", redirect: (context, state) => "/produits"),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <GoRoute>[
            GoRoute(
              path: "/produits",
              name: "produits",
              builder: (context, state) => ProductsPage(),
              routes: [
                GoRoute(
                  path: "/:productId",
                  builder:
                      (context, state) => ProductDetailPage(
                        produitId: state.pathParameters['productId'],
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <GoRoute>[
            GoRoute(
              path: "/panier",
              name: "panier",
              builder: (context, state) => PanierPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: "/compte",
          routes: <GoRoute>[
            GoRoute(
              path: "/compte",
              name: "compte",
              builder: (context, state) => AccountPage(),
              routes: <GoRoute>[
                GoRoute(
                  path: "/informations",
                  name: "mes informations",
                  builder: (context, state) => MyInformationsPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/connexion",
      name: "connexion",
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: "/inscription",
      name: "inscription",
      builder: (context, state) => RegisterPage(),
    ),
  ],
);
