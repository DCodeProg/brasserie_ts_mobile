import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservations_repository.dart';

class UpdateReservation
    implements UseCase<Reservation, UpdateReservationParams> {
  final ReservationsRepository reservationsRepository;

  UpdateReservation({required this.reservationsRepository});

  @override
  Future<Either<Failure, Reservation>> call(
    UpdateReservationParams params,
  ) async {
    return await reservationsRepository.updateReservation(params.reservation);
  }
}

class UpdateReservationParams {
  final Reservation reservation;

  UpdateReservationParams({required this.reservation});
}
