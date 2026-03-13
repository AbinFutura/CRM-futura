import 'package:flutter/material.dart';
import 'package:futura_crm_app/core/UI/base_form_field.dart';

class LeadTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final int maxLines;

  const LeadTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,
      validator: validator,
      maxLines: maxLines,

      decoration: BaseFormField.decoration(
        context: context,
        hint: hint,
        icon: icon,
      ),

    );
  }
}