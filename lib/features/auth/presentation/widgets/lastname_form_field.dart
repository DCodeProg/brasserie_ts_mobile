import 'package:flutter/material.dart';

class LastnameFormField extends StatelessWidget {
  const LastnameFormField({super.key, required this.lastnameController});

  final TextEditingController lastnameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: lastnameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.familyName],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Nom de famille",
        hintText: "Saisissez votre nom de famille",
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Le nom de famille est requis";
        }
        return null;
      },
    );
  }
}
