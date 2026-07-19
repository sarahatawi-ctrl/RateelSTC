import 'package:flutter/material.dart';

Widget buildBanner(String text, ThemeData theme, {VoidCallback? onTap}) {
  return Material(
    color: theme.colorScheme.primary,
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
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
    ),
  );
}
