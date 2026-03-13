import 'package:flutter/material.dart';

class BaseFormField {

  static InputDecoration decoration({
    required BuildContext context,
    required String hint,
    required IconData icon,
  }) {

    final theme = Theme.of(context);

    return InputDecoration(

      hintText: hint,

      prefixIcon: Icon(
        icon,
        color: theme.primaryColor,
      ),

    );

  }

}