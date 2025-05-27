import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../panier/domain/entities/panier.dart';
import '../entities/reservation.dart';
import '../repositories/reservations_repository.dart';

class CreateReservation
    implements UseCase<List<Reservation>, CreateReservationParams> {
  final ReservationsRepository reservationsRepository;

  CreateReservation({
    required this.reservationsRepository,
  });

  @override
  Future<Either<Failure, List<Reservation>>> call(
    CreateReservationParams params,
  ) async {
    return await reservationsRepository.createReservation(
      panier: params.panier,
    );
  }
}

class CreateReservationParams {
  final Panier panier;

  CreateReservationParams({
    required this.panier,
  });
}
