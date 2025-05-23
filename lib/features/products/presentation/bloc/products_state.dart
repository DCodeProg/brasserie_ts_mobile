part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitialState extends ProductsState {}

final class ProductsLoadingState extends ProductsState {}

final class ProductsLoadedState extends ProductsState {
  final List<Product> products;

  const ProductsLoadedState({required this.products});

  @override
  List<Object> get props => [products];
}

final class ProductsFailureState extends ProductsState {
  final String message;

  const ProductsFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
