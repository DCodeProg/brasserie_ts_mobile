import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../panier/domain/entities/panier.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservations_repository.dart';
import '../datasources/reservations_remote_datasource.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  final ReservationsRemoteDatasource remoteDatasource;

  ReservationsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<Reservation>>> createReservation({
    required Panier panier,
  }) async {
    try {
      final reservations = await remoteDatasource.createReservation(panier);
      return right(reservations);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReservation({required int reservationId}) {
    // TODO: implement deleteReservation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Reservation>>> getAllReservations() async {
    try {
      final reservations = await remoteDatasource.getAllReservations();
      return Right(reservations);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
