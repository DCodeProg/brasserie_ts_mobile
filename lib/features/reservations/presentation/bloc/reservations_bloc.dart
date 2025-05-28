import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:brasserie_ts_mobile/features/panier/domain/entities/panier.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/reservation.dart';
import '../../domain/usecases/create_reservation.dart';
import '../../domain/usecases/delete_reservation.dart';
import '../../domain/usecases/get_all_reservations.dart';

part 'reservations_event.dart';
part 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final CreateReservation createReservation;
  final DeleteReservation deleteReservation;
  final GetAllReservations getAllReservations;

  ReservationsBloc({
    required this.createReservation,
    required this.deleteReservation,
    required this.getAllReservations,
  }) : super(ReservationsInitialState()) {
    on<ReservationsCreateReservationEvent>(
      (event, emit) => _onCreateReservationEvent(event, emit),
    );

    on<ReservationsDeleteReservationEvent>(
      (event, emit) => _onDeleteReservationEvent(event, emit),
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
      CreateReservationParams(panier: event.panier),
    );

    res.fold(
      (l) {
        Aptabase.instance.trackEvent('reservation_creation_failed', {
          'error': l.message,
        });
        emit(ReservationsFailureState(l.message));
      },
      (r) {
        Aptabase.instance.trackEvent('reservation_created');
        emit(ReservationsCreatedState(r));
      },
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
