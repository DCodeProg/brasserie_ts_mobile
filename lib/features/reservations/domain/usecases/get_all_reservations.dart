import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservations_repository.dart';

class GetAllReservations implements UseCase<List<Reservation>, NoParams> {
  final ReservationsRepository reservationsRepository;

  GetAllReservations({required this.reservationsRepository});

  @override
  Future<Either<Failure, List<Reservation>>> call([NoParams? params]) async {
    return await reservationsRepository.getAllReservations();
  }
}
