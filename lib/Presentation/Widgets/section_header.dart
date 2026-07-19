import 'package:flutter/material.dart';

Widget buildSectionHeader(String title, String actionText, ThemeData theme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          // الاذكار
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
      Text(
        actionText,
        style: TextStyle(
          //الكل
          fontSize: 20,
          color: theme.colorScheme.primary,
        ),
      ),
    ],
  );
}
