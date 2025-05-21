import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservations_repository.dart';

class CreateReservation implements UseCase<Reservation, ReservationParams> {
  final ReservationsRepository reservationsRepository;

  CreateReservation({required this.reservationsRepository});

  @override
  Future<Either<Failure, Reservation>> call(ReservationParams params) async {
    return await reservationsRepository.createReservation(params.reservation);
  }
}

class ReservationParams {
  final Reservation reservation;

  ReservationParams({required this.reservation});
}
