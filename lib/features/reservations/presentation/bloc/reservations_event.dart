part of 'reservations_bloc.dart';

sealed class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

final class ReservationsCreateReservationEvent extends ReservationsEvent {
  final Panier panier;

  const ReservationsCreateReservationEvent({
    required this.panier,
  });

  @override
  List<Object> get props => [
    panier,
  ];
}

final class ReservationsDeleteReservationEvent extends ReservationsEvent {
  final int reservationId;

  const ReservationsDeleteReservationEvent({
    required this.reservationId,
  });

  @override
  List<Object> get props => [
    reservationId,
  ];
}

final class ReservationsGetAllReservationsEvent extends ReservationsEvent {
  const ReservationsGetAllReservationsEvent();
}
