import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../panier/domain/entities/panier.dart';
import '../models/reservation_model.dart';

abstract interface class ReservationsRemoteDatasource {
  Future<List<ReservationModel>> createReservation(Panier panier);
  Future<void> deleteReservation(int reservationId);
  Future<List<ReservationModel>> getAllReservations();
}

class ReservationsRemoteDatasourceImpl implements ReservationsRemoteDatasource {
  final SupabaseClient supabaseClient;

  ReservationsRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<List<ReservationModel>> createReservation(Panier panier) async {
    final userId = supabaseClient.auth.currentUser?.id;

    if (userId == null) {
      throw ServerException(message: 'User not authenticated');
    }

    // Insert reservation
    final reservationResponse = await supabaseClient
        .from('reservations')
        .insert({
          'client_uid': userId,
        })
        .select()
        .single();

    final reservationId = reservationResponse['id'];

    // Insert reservation_produits
    for (final panierItem in panier.panierItems) {
      await supabaseClient.from('reservation_produits').insert({
        'reservation_id': reservationId,
        'produit_id': panierItem.product.id,
        'quantite': panierItem.quantity,
      });
    }

    return getAllReservations();
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
