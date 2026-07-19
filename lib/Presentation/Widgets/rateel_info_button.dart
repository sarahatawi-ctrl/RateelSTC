import 'package:flutter/material.dart';
import '../screens/about_rateel.dart';

Widget buildRateelInfoButton(BuildContext context, ThemeData theme) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutRateel()),
      );
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),

      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'اعرف أكثر عن رتيل',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),

          Icon(
            Icons.arrow_forward_ios,
            color: theme.textTheme.bodyLarge?.color,
            size: 20,
          ),
        ],
      ),
    ),
  );
}
