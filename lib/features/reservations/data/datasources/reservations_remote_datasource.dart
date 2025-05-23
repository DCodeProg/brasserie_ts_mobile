import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/reservation_model.dart';

abstract interface class ReservationsRemoteDatasource {
  Future<ReservationModel> createReservation(ReservationModel reservation);
  Future<void> deleteReservation(int reservationId);
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
    final reservations = await supabaseClient
        .from('reservations')
        .select(
          '''*, reservation_produits (
        quantite,
        produit:produits (
          id,
          nom,
          description,
          prix,
          categorie(*),
          image_url,
          volume,
          degre,
          quantite
        )
      )''',
        )
        .eq('client_uid', supabaseClient.auth.currentUser!.id);

    return reservations
        .map((reservation) => ReservationModel.fromMap(reservation))
        .toList();
  }
}
