part of 'reservations_bloc.dart';

sealed class ReservationsState extends Equatable {
  const ReservationsState();  

  @override
  List<Object> get props => [];
}

final class ReservationsInitialState extends ReservationsState {}

final class ReservationsLoadingState extends ReservationsState {}

final class ReservationsLoadedState extends ReservationsState {
  final List<Reservation> reservations;

  const ReservationsLoadedState(this.reservations);

  @override
  List<Object> get props => [reservations];
}

final class ReservationsEmptyState extends ReservationsState {}

final class ReservationsFailureState extends ReservationsState {
  final String message;

  const ReservationsFailureState(this.message);

  @override
  List<Object> get props => [message];
}

final class ReservationsCreatedState extends ReservationsState {
  final Reservation reservation;

  const ReservationsCreatedState(this.reservation);

  @override
  List<Object> get props => [reservation];
}