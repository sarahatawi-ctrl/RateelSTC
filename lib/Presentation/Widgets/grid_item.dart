import 'package:flutter/material.dart';

// بوكسات في شاشه الاذكار
Widget buildGridItem(
  BuildContext context,
  String title,
  IconData icon,
  Color iconColor, {
  VoidCallback? onTap,
}) {
  final theme = Theme.of(context);
  return Material(
    color: theme.colorScheme.secondary,
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
