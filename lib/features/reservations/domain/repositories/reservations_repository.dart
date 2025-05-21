import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/reservation.dart';

abstract interface class ReservationsRepository {
  Future<Either<Failure, Reservation>> createReservation(Reservation reservation);
  Future<Either<Failure, Reservation>> updateReservation(Reservation reservation);
  Future<Either<Failure, void>> deleteReservation(int reservationId);
  Future<Either<Failure, Reservation?>> getReservationById(int reservationId);
  Future<Either<Failure, List<Reservation>>> getAllReservations();
}