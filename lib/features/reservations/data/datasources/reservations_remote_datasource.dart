import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/reservation_model.dart';

abstract interface class ReservationsRemoteDatasource {
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<ReservationModel> updateReservation(ReservationModel reservation);
  Future<void> deleteReservation(int reservationId);
  Future<ReservationModel?> getReservationById(int reservationId);
  Future<List<ReservationModel>> getAllReservations();
}

class ReservationsRemoteDatasourceImpl implements ReservationsRemoteDatasource {
  final SupabaseClient supabaseClient;

  ReservationsRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<ReservationModel> createReservation(ReservationModel reservation) {
    // TODO: implement createReservation
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReservation(int reservationId) {
    // TODO: implement deleteReservation
    throw UnimplementedError();
  }

  @override
  Future<List<ReservationModel>> getAllReservations() async {
    final reservations = await supabaseClient.from('reservations').select();

    print(reservations);

    return reservations
        .map((reservation) => ReservationModel.fromMap(reservation))
        .toList();
  }

  @override
  Future<ReservationModel?> getReservationById(int reservationId) async {
    final reservation = await supabaseClient
        .from('reservations')
        .select()
        .eq('id', reservationId)
        .single();

    return ReservationModel.fromMap(reservation);
  }
  
  @override
  Future<ReservationModel> updateReservation(ReservationModel reservation) {
    // TODO: implement updateReservation
    throw UnimplementedError();
  }
}