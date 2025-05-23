import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../panier/domain/entities/panier.dart';
import '../entities/reservation.dart';

abstract interface class ReservationsRepository {
  Future<Either<Failure, Reservation>> createReservation({
    required Panier panier,
  });
  Future<Either<Failure, void>> deleteReservation({
    required int reservationId,
  });
  Future<Either<Failure, List<Reservation>>> getAllReservations();
}
