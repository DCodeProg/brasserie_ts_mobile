import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'features/panier/data/datasources/panier_local_datasource.dart';
import 'features/panier/data/repositories/panier_repository_impl.dart';
import 'features/panier/domain/repositories/panier_repository.dart';
import 'features/panier/domain/usecases/add_item.dart';
import 'features/panier/domain/usecases/clear_items.dart';
import 'features/panier/domain/usecases/load_panier.dart';
import 'features/panier/domain/usecases/remove_item.dart';
import 'features/panier/domain/usecases/update_item_quantity.dart';
import 'features/panier/presentation/bloc/panier_bloc.dart';
import 'features/produits/data/datasources/products_remote_datasource.dart';
import 'features/produits/data/repositories/products_repository_impl.dart';
import 'features/produits/domain/repositories/products_repository.dart';
import 'features/produits/domain/usecases/fetch_all_products.dart';
import 'features/produits/presentation/bloc/products_bloc.dart';
import 'features/reservations/data/datasources/reservations_remote_datasource.dart';
import 'features/reservations/data/repositories/reservations_repository_impl.dart';
import 'features/reservations/domain/repositories/reservations_repository.dart';
import 'features/reservations/domain/usecases/create_reservation.dart';
import 'features/reservations/domain/usecases/delete_reservation.dart';
import 'features/reservations/domain/usecases/get_all_reservations.dart';
import 'features/reservations/presentation/bloc/reservations_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: '.env');

  await Aptabase.init(
    dotenv.env['APTABASE_APP_KEY']!,
    InitOptions(host: "https://aptabase-bts.host-dcode.fr"),
  );

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

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  initAuth();
  initCategoriesBloc();
  initProductsBloc();
  initPanier();
  initReservations();
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

void initPanier() {
  getIt
    // Datasources
    ..registerFactory<PanierLocalDatasource>(
      () => PanierLocalDatasourceImpl(sharedPreferences: getIt()),
    )
    // Repositories
    ..registerFactory<PanierRepository>(
      () => PanierRepositoryImpl(localDatasource: getIt()),
    )
    // Usecases
    ..registerFactory(() => AddItem(panierRepository: getIt()))
    ..registerFactory(() => ClearItems(panierRepository: getIt()))
    ..registerFactory(() => LoadPanier(panierRepository: getIt()))
    ..registerFactory(() => RemoveItem(panierRepository: getIt()))
    ..registerFactory(() => UpdateItemQuantity(panierRepository: getIt()))
    // Bloc
    ..registerLazySingleton(
      () => PanierBloc(
        addItem: getIt(),
        clearItems: getIt(),
        loadPanier: getIt(),
        removeItem: getIt(),
        updateItemQuantity: getIt(),
      ),
    );
}

void initReservations() {
  getIt
    // Datasources
    ..registerFactory<ReservationsRemoteDatasource>(
      () => ReservationsRemoteDatasourceImpl(supabaseClient: getIt()),
    )
    // Repositories
    ..registerFactory<ReservationsRepository>(
      () => ReservationsRepositoryImpl(remoteDatasource: getIt()),
    )
    // Usecases
    ..registerFactory(() => CreateReservation(reservationsRepository: getIt()))
    ..registerFactory(() => DeleteReservation(reservationsRepository: getIt()))
    ..registerFactory(() => GetAllReservations(reservationsRepository: getIt()))
    // Bloc
    ..registerLazySingleton(
      () => ReservationsBloc(
        createReservation: getIt(),
        deleteReservation: getIt(),
        getAllReservations: getIt(),
      ),
    );
}
