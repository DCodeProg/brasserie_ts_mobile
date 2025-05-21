import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/reservation.dart';
import '../../domain/usecases/create_reservation.dart';
import '../../domain/usecases/delete_reservation.dart';
import '../../domain/usecases/get_all_reservations.dart';
import '../../domain/usecases/get_reservation_by_id.dart';
import '../../domain/usecases/update_reservation.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final CreateReservation createReservation;
  final UpdateReservation updateReservation;
  final DeleteReservation deleteReservation;
  final GetReservationById getReservationById;
  final GetAllReservations getAllReservations;

  ReservationsBloc({
    required this.createReservation,
    required this.updateReservation,
    required this.deleteReservation,
    required this.getReservationById,
    required this.getAllReservations,
  }) : super(ReservationsInitialState()) {
    on<ReservationsCreateReservationEvent>(
      (event, emit) => _onCreateReservationEvent(event, emit),
    );

    on<ReservationsDeleteReservationEvent>(
      (event, emit) => _onDeleteReservationEvent(event, emit),
    );

    on<ReservationsUpdateReservationEvent>(
      (event, emit) => _onUpdateReservationEvent(event, emit),
    );

    on<ReservationsGetReservationByIdEvent>(
      (event, emit) => _onGetReservationByIdEvent(event, emit),
    );

    on<ReservationsGetAllReservationsEvent>(
      (event, emit) => _onGetAllReservationsEvent(event, emit),
    );

    add(ReservationsGetAllReservationsEvent());
  }

  Future<void> _onCreateReservationEvent(
    ReservationsCreateReservationEvent event,
    Emitter emit,
  ) async {
    emit(ReservationsLoadingState());

    final res = await createReservation(
      ReservationParams(reservation: event.reservation),
    );

    res.fold(
      (l) => emit(ReservationsFailureState(l.message)),
      (r) => emit(ReservationsCreatedState(r)),
    );
  }

  Future<void> _onDeleteReservationEvent(
    ReservationsDeleteReservationEvent event,
    Emitter emit,
  ) async {
    emit(ReservationsLoadingState());

    final res = await deleteReservation(
      DeleteReservationParams(reservationId: event.reservationId),
    );

    res.fold(
      (l) => emit(ReservationsFailureState(l.message)),
      (r) => add(ReservationsGetAllReservationsEvent()),
    );
  }

  Future<void> _onUpdateReservationEvent(
    ReservationsUpdateReservationEvent event,
    Emitter emit,
  ) async {
    emit(ReservationsLoadingState());

    final res = await updateReservation(
      UpdateReservationParams(reservation: event.reservation),
    );

    res.fold(
      (l) => emit(ReservationsFailureState(l.message)),
      (r) => emit(ReservationsCreatedState(r)),
    );
  }

  Future<void> _onGetReservationByIdEvent(
    ReservationsGetReservationByIdEvent event,
    Emitter emit,
  ) async {
    emit(ReservationsLoadingState());

    final res = await getReservationById(
      GetReservationByIdParams(reservationId: event.reservationId),
    );

    res.fold((l) => emit(ReservationsFailureState(l.message)), (r) {
      if (r != null) {
        emit(ReservationsLoadedState([r]));
      } else {
        emit(ReservationsFailureState('Reservation not found'));
      }
    });
  }

  Future<void> _onGetAllReservationsEvent(
    ReservationsGetAllReservationsEvent event,
    Emitter emit,
  ) async {
    emit(ReservationsLoadingState());

    final res = await getAllReservations();

    res.fold((l) => emit(ReservationsFailureState(l.message)), (r) {
      if (r.isEmpty) {
        emit(ReservationsEmptyState());
      } else {
        emit(ReservationsLoadedState(r));
      }
    });
  }
}
