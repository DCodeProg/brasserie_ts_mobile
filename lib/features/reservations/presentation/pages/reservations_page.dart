import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              final reservations = (state).reservations;
              return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return ListTile(
                    title: Text(reservation.id.toString()),
                    subtitle: Text(reservation.etat),
                  );
                },
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
