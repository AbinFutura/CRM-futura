import 'package:flutter/material.dart';

class LeadSectionCard extends StatelessWidget {

  final String title;
  final List<Widget> children;

  const LeadSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Card(

      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: textTheme.titleMedium,
            ),

            const SizedBox(height: 12),

            ...children,

          ],
        ),
      ),
    );
  }
}