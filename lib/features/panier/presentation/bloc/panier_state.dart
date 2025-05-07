part of 'panier_bloc.dart';

sealed class PanierState extends Equatable {
  const PanierState();

  @override
  List<Object> get props => [];
}

final class PanierLoadingState extends PanierState {}

final class PanierEmptyState extends PanierState {}

final class PanierLoadedState extends PanierState {
  final Panier panier;

  const PanierLoadedState({required this.panier});

  @override
  List<Object> get props => [panier];
}

final class PanierFailureState extends PanierState {
  final String message;

  const PanierFailureState({required this.message});

  @override
  List<Object> get props => [message];
}
