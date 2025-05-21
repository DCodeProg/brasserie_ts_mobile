import 'package:brasserie_ts_mobile/core/errors/failures.dart';
import 'package:brasserie_ts_mobile/core/usecase/usecase.dart';
import 'package:brasserie_ts_mobile/features/reservations/domain/entities/reservation.dart';
import 'package:brasserie_ts_mobile/features/reservations/domain/repositories/reservations_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetReservationById
    implements UseCase<Reservation?, GetReservationByIdParams> {
  final ReservationsRepository reservationsRepository;

  GetReservationById({required this.reservationsRepository});

  @override
  Future<Either<Failure, Reservation?>> call(
    GetReservationByIdParams params,
  ) async {
    return await reservationsRepository.getReservationById(params.reservationId);
  }
}

class GetReservationByIdParams {
  final int reservationId;

  GetReservationByIdParams({required this.reservationId});
}
