import 'package:flutter/material.dart';

class FirstnameFormField extends StatelessWidget {
  const FirstnameFormField({super.key, required this.firstnameController});

  final TextEditingController firstnameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstnameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.givenName],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Prénom",
        hintText: "Saisissez votre prénom",
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Le prénom est requis";
        }
        return null;
      },
    );
  }
}
