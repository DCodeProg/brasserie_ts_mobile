import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/reservations_repository.dart';

class DeleteReservation implements UseCase<void, DeleteReservationParams> {
  final ReservationsRepository reservationsRepository;

  DeleteReservation({required this.reservationsRepository});

  @override
  Future<Either<Failure, void>> call(DeleteReservationParams params) async {
    return await reservationsRepository.deleteReservation(params.reservationId);
  }
}

class DeleteReservationParams {
  final int reservationId;

  DeleteReservationParams({required this.reservationId});
}
