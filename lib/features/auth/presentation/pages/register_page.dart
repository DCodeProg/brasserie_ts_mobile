import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/widgets/gradient_single_schild_scroll_view.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/email_form_field.dart';
import '../widgets/firstname_form_field.dart';
import '../widgets/lastname_form_field.dart';
import '../widgets/password_form_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.canPop() ? context.pop() : context.go('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inscription"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return LinearProgressIndicator();
                }
                return Container();
              },
            ),
          ),
        ),
        body: GradientSingleSchildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 24.0,
              top: 20,
              left: 16,
              right: 16,
            ),
            child: Column(
              spacing: 24,
              children: [
                _RegisterHeader(),
                _RegisterForm(),
                _AlreadyAccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bienvenue !", style: TextTheme.of(context).displaySmall),
          Text(
            "Saisissez vos informations personnelles pour créer votre compte afin de pouvoir passer vos réservations",
            style: TextTheme.of(context).titleSmall?.copyWith(
              color: ColorScheme.of(context).onSurfaceVariant,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  _RegisterForm();

  final formKey = GlobalKey<FormState>();
  final lastnameController = TextEditingController();
  final firstnameController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: AutofillGroup(
        child: Column(
          spacing: 16,
          children: [
            LastnameFormField(lastnameController: lastnameController),
            FirstnameFormField(firstnameController: firstnameController),
            EmailFormField(emailTextController: emailTextController),
            PasswordFormField(passwordTextController: passwordTextController),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return _RegisterButton(
                  formKey: formKey,
                  emailTextController: emailTextController,
                  passwordTextController: passwordTextController,
                  lastnameTextController: lastnameController,
                  firstnameTextController: firstnameController,
                );
              },
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthFailureState) {
                  return Text(
                    state.message,
                    style: TextTheme.of(context).labelLarge?.copyWith(
                      color: ColorScheme.of(context).error,
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    required this.formKey,
    required this.lastnameTextController,
    required this.firstnameTextController,
    required this.emailTextController,
    required this.passwordTextController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController lastnameTextController;
  final TextEditingController firstnameTextController;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    void submitRegisterForm() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(
          AuthSignUpEvent(
            nom: lastnameTextController.text,
            prenom: firstnameTextController.text,
            email: emailTextController.text,
            password: passwordTextController.text,
          ),
        );
      }
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {
          HapticFeedback.selectionClick();
          submitRegisterForm();
        },
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
        ),
        icon: Icon(Icons.login),
        label: Text("S'inscrire"),
      ),
    );
  }
}

class _AlreadyAccountButton extends StatelessWidget {
  const _AlreadyAccountButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        context.replaceNamed("connexion");
      },
      child: RichText(
        text: TextSpan(
          text: "Déjà un compte ? ",
          style: TextTheme.of(context).bodySmall,
          children: [
            TextSpan(
              text: "Se connecter",
              style: TextStyle(color: ColorScheme.of(context).secondary),
            ),
          ],
        ),
      ),
    );
  }
}
