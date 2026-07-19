import 'package:flutter/material.dart';
import '../../Domain/Entities/athkar_item.dart';

Widget buildAthkarItemCard(
  ThemeData theme,
  AthkarItem item,
  int remaining,
  VoidCallback onTap,
) {
  final done = remaining == 0;

  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: done
            ? theme.colorScheme.primary.withValues(alpha: 0.25)
            : theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: done ? theme.colorScheme.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.text,
            style: TextStyle(
              fontSize: 17,
              height: 1.8,
              color: theme.textTheme.bodyLarge?.color ?? Colors.white,
            ),
          ),
          if (item.footnote != null) ...[
            const SizedBox(height: 8),
            Text(
              item.footnote!,
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
          if (item.repeat > 1) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: done
                    ? theme.colorScheme.secondary
                    : theme.colorScheme.primary,
                child: Text(
                  '$remaining',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
