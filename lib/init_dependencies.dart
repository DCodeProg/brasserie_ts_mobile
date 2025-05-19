import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'core/shared/cubit/theme_cubit.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/sign_in_with_password.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/categories/data/datasources/categories_remote_datasource.dart';
import 'features/categories/data/repositories/categories_repository_impl.dart';
import 'features/categories/domain/repositories/categories_repository.dart';
import 'features/categories/domain/usecases/fetch_all_categories.dart';
import 'features/categories/presentation/bloc/categories_bloc.dart';
import 'features/produits/data/datasources/products_remote_datasource.dart';
import 'features/produits/data/repositories/products_repository_impl.dart';
import 'features/produits/domain/repositories/products_repository.dart';
import 'features/produits/domain/usecases/fetch_all_products.dart';
import 'features/produits/presentation/bloc/products_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: '.env');

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  getIt.registerLazySingleton(() => supabase.client);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  getIt.registerLazySingleton(() => ThemeCubit());

  initAuth();
  initCategoriesBloc();
  initProductsBloc();
}

void initAuth() {
  getIt
    // Datasources
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImplt(supabaseClient: getIt()),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDatasource: getIt()),
    )
    // Usecases
    ..registerFactory(() => GetCurrentUser(authRepository: getIt()))
    ..registerFactory(() => SignInWithPassword(authRepository: getIt()))
    ..registerFactory(() => SignUp(authRepository: getIt()))
    ..registerFactory(() => SignOut(authRepository: getIt()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        getCurrentUser: getIt(),
        signInWithPassword: getIt(),
        signOut: getIt(),
        signUp: getIt(),
      ),
    );
}

void initCategoriesBloc() {
  getIt
    // Datasources
    ..registerFactory<CategoriesRemoteDatasource>(
      () => CategoriesRemoteDatasourceImpl(supabaseClient: getIt()),
    )
    // Repositories
    ..registerFactory<CategoriesRepository>(
      () => CategoriesRepositoryImpl(remoteDatasource: getIt()),
    )
    // Usecases
    ..registerFactory(() => FetchAllCategories(categoriesRepository: getIt()))
    // Bloc
    ..registerLazySingleton(() => CategoriesBloc(fetchAllCategories: getIt()));
}

void initProductsBloc() {
  getIt
    // Datasources
    ..registerFactory<ProductsRemoteDatasource>(
      () => ProductsRemoteDatasourceImpl(supabaseClient: getIt()),
    )
    // Repositories
    ..registerFactory<ProductsRepository>(
      () => ProductsRepositoryImpl(remoteDatasource: getIt()),
    )
    // Usecases
    ..registerFactory(() => FetchAllProducts(productsRepository: getIt()))
    // Bloc
    ..registerLazySingleton(() => ProductsBloc(fetchAllProducts: getIt()));
}
