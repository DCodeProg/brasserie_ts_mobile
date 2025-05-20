import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/widgets/gradient_single_schild_scroll_view.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/email_form_field.dart';
import '../widgets/password_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          title: Text("Connexion"),
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
              children: [_LoginHeader(), _LoginForm(), _NoAccountButton()],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rebonjour !", style: TextTheme.of(context).displaySmall),
          Text(
            "Saisissez votre email et votre mot de passe pour vous connecter à votre compte",
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

class _LoginForm extends StatelessWidget {
  _LoginForm();

  final formKey = GlobalKey<FormState>();
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: AutofillGroup(
        child: Column(
          spacing: 16,
          children: [
            EmailFormField(emailTextController: emailTextController),
            _PasswordFormFieldGroup(
              passwordTextController: passwordTextController,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return _LoginButton(
                  formKey: formKey,
                  emailTextController: emailTextController,
                  passwordTextController: passwordTextController,
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

class _PasswordFormFieldGroup extends StatelessWidget {
  const _PasswordFormFieldGroup({required this.passwordTextController});

  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordFormField(passwordTextController: passwordTextController),
        SizedBox(height: 4),
        Align(alignment: Alignment.centerRight, child: _ForgotPasswordButton()),
      ],
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        // TODO: Redirect to reset password
      },
      child: Text(
        "Mot de passe oublié ?",
        style: TextStyle(color: ColorScheme.of(context).tertiary),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.formKey,
    required this.emailTextController,
    required this.passwordTextController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    void submitLoginForm() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(
          AuthSignInWithPasswordEvent(
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
          submitLoginForm();
        },
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
        ),
        icon: Icon(Icons.login),
        label: Text("Se connecter"),
      ),
    );
  }
}

class _NoAccountButton extends StatelessWidget {
  const _NoAccountButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HapticFeedback.selectionClick();
        context.replaceNamed("inscription");
      },
      child: RichText(
        text: TextSpan(
          text: "Pas de compte ? ",
          style: TextTheme.of(context).bodySmall,
          children: [
            TextSpan(
              text: "Créer un compte",
              style: TextStyle(color: ColorScheme.of(context).secondary),
            ),
          ],
        ),
      ),
    );
  }
}
