import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/category.dart';
import '../../domain/usecases/fetch_all_categories.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final FetchAllCategories fetchAllCategories;

  CategoriesBloc({required this.fetchAllCategories})
    : super(CategoriesInitialState()) {
    on<CategoriesFetchAllCategoriesEvent>(
      (event, emit) => _onFetchAllCategories(event, emit),
    );

    add(CategoriesFetchAllCategoriesEvent());
  }

  Future<void> _onFetchAllCategories(
    CategoriesFetchAllCategoriesEvent event,
    Emitter emit,
  ) async {
    emit(CategoriesLoadingState());

    final res = await fetchAllCategories();

    res.fold(
      (l) => emit(CategoriesFailureState(message: l.message)),
      (r) => emit(CategoriesLoadedState(categories: r)),
    );
  }

  Category? getCategoryById(String categoryId) {
    if (state is CategoriesLoadedState) {
      return (state as CategoriesLoadedState).categories
          .where((category) => category.id == categoryId)
          .first;
    }
    return null;
  }
}
