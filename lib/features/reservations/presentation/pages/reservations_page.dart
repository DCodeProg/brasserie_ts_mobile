import 'package:brasserie_ts_mobile/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../bloc/reservations_bloc.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes réservations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ReservationsBloc>().add(
                ReservationsGetAllReservationsEvent(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ReservationsBloc, ReservationsState>(
        builder: (context, state) {
          switch (state) {
            case ReservationsInitialState():
              return Center(child: Text("Aucune réservation trouvée"));
            case ReservationsLoadingState():
              return Center(child: CircularProgressIndicator());
            case ReservationsFailureState():
              return Center(
                child: Text(
                  "Erreur lors du chargement des réservations : ${state.message}",
                ),
              );
            case ReservationsLoadedState():
              var reservations = (state).reservations;
              reservations.sort(
                (a, b) => b.id.compareTo(a.id),
              );
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = reservations[index];
                    final panierItems = reservation.panier.panierItems;
                    final totalPrice = panierItems.fold<double>(
                      0,
                      (sum, item) => sum + (item.product.price * item.quantity),
                    );
                    return Card.outlined(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: ColorScheme.of(context).surfaceContainer,
                      child: ExpansionTile(
                        title: Text('Réservation #${reservation.id}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Du ${DateFormatter.dateTimeToDayMonthYear(reservation.createdAt)}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Statut : ${reservation.etat}",
                              style: TextStyle(
                                color: ColorScheme.of(context).secondary,
                              ),
                            ),
                            Text(
                              'Total: ${totalPrice.toStringAsFixed(2)} €',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: [
                          if (panierItems.isNotEmpty)
                            ...panierItems.map<Widget>(
                              (productItem) => ListTile(
                                title: Text(productItem.product.name),
                                subtitle: Text(
                                  'Quantité: ${productItem.quantity} - Prix unitaire: ${productItem.product.price.toStringAsFixed(2)} €',
                                ),
                                trailing: Text(
                                  'Total: ${(productItem.product.price * productItem.quantity).toStringAsFixed(2)} €',
                                ),
                              ),
                            ),
                          if (panierItems.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Aucun produit dans cette réservation',
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            case ReservationsEmptyState():
              return Center(child: Text("Aucune réservation trouvée"));
            case ReservationsCreatedState():
              return Center(child: Text("Réservation créée avec succès"));
          }
        },
      ),
    );
  }
}
