import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/fetch_all_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchAllProducts fetchAllProducts;

  ProductsBloc({required this.fetchAllProducts})
    : super(ProductsInitialState()) {
    on<ProductsFetchAllProductsEvent>(
      (event, emit) => _onFetchAllProductsEvent(event, emit),
    );

    add(ProductsFetchAllProductsEvent());
  }

  Future<void> _onFetchAllProductsEvent(
    ProductsFetchAllProductsEvent event,
    Emitter emit,
  ) async {
    emit(ProductsLoadingState());

    final res = await fetchAllProducts();

    res.fold(
      (l) => emit(ProductsFailureState(message: l.message)),
      (r) => emit(ProductsLoadedState(products: r)),
    );
  }
}
