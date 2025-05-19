import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../cubit/theme_cubit.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compte", style: TextTheme.of(context).displaySmall),
      ),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccessState) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: _AvatarWidget(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              _MyInfosTile(),
                              Divider(height: 0),
                              _AppThemeTile(),
                              Divider(height: 0),
                              _SignOutTile(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: _AvatarWidget(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              // _MyInfosTile(),
                              // Divider(height: 0),
                              _SignInTile(),
                              Divider(height: 0),
                              _AppThemeTile(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MyInfosTile extends StatelessWidget {
  const _MyInfosTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Mes informations"),
      leading: Icon(Icons.account_circle),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        HapticFeedback.selectionClick();
        context.push("/compte/informations");
      },
    );
  }
}

class _SignOutTile extends StatelessWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Se déconnecter"),
      leading: Icon(Icons.logout),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        HapticFeedback.selectionClick();
        context.read<AuthBloc>().add(AuthSignOutEvent());
      },
    );
  }
}

class _SignInTile extends StatelessWidget {
  const _SignInTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Se connecter"),
      leading: Icon(Icons.login),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        HapticFeedback.selectionClick();
        context.pushNamed("connexion");
      },
    );
  }
}

class _AppThemeTile extends StatelessWidget {
  const _AppThemeTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Thème de l'application"),
      leading: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return Icon(switch (state) {
            ThemeMode.system => Icons.brightness_auto_outlined,
            ThemeMode.light => Icons.light_mode_outlined,
            ThemeMode.dark => Icons.dark_mode_outlined,
          });
        },
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Text("Choisissez le thème de l'application"),
              children: [
                SimpleDialogOption(
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.brightness_auto_outlined),
                      Text("Thème système"),
                    ],
                  ),
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    context.read<ThemeCubit>().selectThemeMode(
                      ThemeMode.system,
                    );
                    context.pop();
                  },
                ),
                SimpleDialogOption(
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.light_mode_outlined),
                      Text("Thème clair"),
                    ],
                  ),
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    context.read<ThemeCubit>().selectThemeMode(ThemeMode.light);
                    context.pop();
                  },
                ),
                SimpleDialogOption(
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.dark_mode_outlined),
                      Text("Thème sombre"),
                    ],
                  ),
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    context.read<ThemeCubit>().selectThemeMode(ThemeMode.dark);
                    context.pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 3)),
        CircleAvatar(
          backgroundColor: ColorScheme.of(context).primaryContainer,
          radius: 82,
          child: CircleAvatar(
            backgroundColor: ColorScheme.of(context).surfaceContainerHighest,
            radius: 80,
            child: CircleAvatar(
              backgroundColor: ColorScheme.of(context).tertiaryContainer,
              radius: 76,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccessState) {
                    return Text(
                      state.user.prenom.substring(0, 1) +
                          state.user.nom.substring(0, 1),
                      style: TextTheme.of(context).displayLarge,
                    );
                  } else {
                    return Icon(Icons.person_outline, size: 100);
                  }
                },
              ),
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 3)),
      ],
    );
  }
}
