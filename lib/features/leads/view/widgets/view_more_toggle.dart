import 'package:flutter/material.dart';

class ViewMoreToggle extends StatelessWidget {

  final bool expanded;
  final VoidCallback onTap;

  const ViewMoreToggle({
    super.key,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,

      child: TextButton.icon(

        onPressed: onTap,

        icon: Icon(
          expanded
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          size: 18,
        ),

        label: Text(
          expanded ? "Hide" : "View More",
          style: textTheme.bodySmall,
        ),

        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}