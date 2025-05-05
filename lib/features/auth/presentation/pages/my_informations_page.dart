import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/date_formatter.dart';
import '../bloc/auth_bloc.dart';

class MyInformationsPage extends StatelessWidget {
  const MyInformationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes informations")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "${state.user.nom.toUpperCase()} ${state.user.prenom}",
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(Icons.person),
                          ),
                          Divider(height: 0),
                          ListTile(
                            title: Text(
                              state.user.email,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(Icons.alternate_email),
                          ),
                          Divider(height: 0),
                          ListTile(
                            title: Text(
                              DateFormatter.dateTimeToDayMonthYear(
                                state.user.dateNaissance,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(Icons.cake),
                          ),
                          Divider(height: 0),
                          ListTile(
                            title: Text(
                              DateFormatter.dateTimeToDayMonthYearHourMinSec(
                                state.user.createdAt,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(Icons.calendar_month),
                          ),
                          Divider(height: 0),
                          ListTile(
                            title: Text(state.user.uid),
                            leading: Icon(Icons.tag),
                            trailing: Icon(Icons.copy),
                            onTap: () {
                              HapticFeedback.selectionClick();
                              Clipboard.setData(
                                ClipboardData(text: state.user.uid),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Placeholder();
                }
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text("Modifier des informations"),
              ),
            ),
            SizedBox(
              width: 250,
              child: FilledButton.icon(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    ColorScheme.of(context).errorContainer,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    ColorScheme.of(context).onErrorContainer,
                  ),
                ),
                icon: Icon(Icons.delete_forever),
                label: Text("Supprimer mon compte"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
