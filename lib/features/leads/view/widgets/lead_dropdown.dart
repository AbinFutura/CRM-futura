import 'package:flutter/material.dart';
import '../../../../core/ui/base_form_field.dart';

class LeadDropdown extends StatelessWidget {

  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String hint;
  final IconData icon;

  const LeadDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(

      value: value,

      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: theme.textTheme.bodyMedium,
          ),
        );
      }).toList(),

      onChanged: onChanged,

      decoration: BaseFormField.decoration(
        context: context,
        hint: hint,
        icon: icon,
      ),

      style: theme.textTheme.bodyMedium,

      borderRadius: BorderRadius.circular(10),

    );
  }
}