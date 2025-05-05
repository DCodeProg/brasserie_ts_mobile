import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({super.key, required this.passwordTextController});

  final TextEditingController passwordTextController;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool passwordObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      passwordObscured = !passwordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordTextController,
      autofillHints: [AutofillHints.password],
      enableSuggestions: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Mot de passe",
        hintText: "Saisissez votre mot de passe",
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 4, right: 4, bottom: 4),
          child: IconButton(
            onPressed: _togglePasswordVisibility,
            icon: Icon(
              passwordObscured
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
        ),
        filled: true,
      ),
      validator: (value) {
        if (value == null || value == "") {
          return "Un mot de passe est requis";
        }
        return null;
      },
      obscureText: passwordObscured,
    );
  }
}
