part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitialState extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  final List<Category> categories;

  const CategoriesLoadedState({required this.categories});

  @override
  List<Object> get props => [categories];
}

final class CategoriesFailureState extends CategoriesState {
  final String message;

  const CategoriesFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
