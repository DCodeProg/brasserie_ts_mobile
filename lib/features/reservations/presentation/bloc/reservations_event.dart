part of 'reservations_bloc.dart';

sealed class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

final class ReservationsCreateReservationEvent extends ReservationsEvent {
  final Reservation reservation;

  const ReservationsCreateReservationEvent(this.reservation);

  @override
  List<Object> get props => [reservation];
}

final class ReservationsDeleteReservationEvent extends ReservationsEvent {
  final int reservationId;

  const ReservationsDeleteReservationEvent(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}

final class ReservationsUpdateReservationEvent extends ReservationsEvent {
  final Reservation reservation;

  const ReservationsUpdateReservationEvent(this.reservation);

  @override
  List<Object> get props => [reservation];
}

final class ReservationsGetReservationByIdEvent extends ReservationsEvent {
  final int reservationId;

  const ReservationsGetReservationByIdEvent(this.reservationId);

  @override
  List<Object> get props => [reservationId];
}

final class ReservationsGetAllReservationsEvent extends ReservationsEvent {
  const ReservationsGetAllReservationsEvent();
}
