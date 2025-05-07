import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/app_router.dart';
import 'core/shared/cubit/theme_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/text_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/categories/presentation/bloc/categories_bloc.dart';
import 'features/panier/presentation/bloc/panier_bloc.dart';
import 'features/produits/presentation/bloc/products_bloc.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<CategoriesBloc>()),
        BlocProvider(create: (context) => getIt<ProductsBloc>()),
        BlocProvider(create: (context) => getIt<PanierBloc>()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      bodyFontString: "Noto Sans",
      displayFontString: "Rye",
    );
    MaterialTheme theme = MaterialTheme(textTheme);

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
