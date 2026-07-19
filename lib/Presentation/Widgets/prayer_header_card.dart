import 'package:flutter/material.dart';
import '../../Domain/Entities/prayer_times.dart';

String _two(int n) => n.toString().padLeft(2, '0');

Widget buildPrayerHeaderCard({
  required ThemeData theme,
  required DateTime now,
  required String cityName,
  required PrayerTimes? prayerTimes,
  required bool isLoading,
}) {
  final nextEntry = prayerTimes?.nextPrayer(now);
  final countdown = nextEntry?.value.difference(now);

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          theme.colorScheme.primary,
          theme.colorScheme.primary.withValues(alpha: 0.75),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 18),
                const SizedBox(width: 4),
                Text(
                  cityName,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            if (prayerTimes != null)
              Text(
                '${prayerTimes.hijriWeekday} ${prayerTimes.hijriDate}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '${_two(now.hour)}:${_two(now.minute)}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (isLoading)
          const Text(
            '...جاري تحديد الموقع',
            style: TextStyle(color: Colors.white70),
          )
        else if (nextEntry != null && countdown != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'صلاة ${nextEntry.key} خلال ${_two(countdown.inHours)}:${_two(countdown.inMinutes.remainder(60))}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          const Text(
            'تعذر جلب أوقات الصلاة',
            style: TextStyle(color: Colors.white70),
          ),
        if (prayerTimes != null) ...[
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: prayerTimes.ordered.map((entry) {
              final isNext = nextEntry != null && entry.key == nextEntry.key;
              return Column(
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      color: isNext ? Colors.white : Colors.white60,
                      fontSize: 12,
                      fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_two(entry.value.hour)}:${_two(entry.value.minute)}',
                    style: TextStyle(
                      color: isNext ? Colors.white : Colors.white60,
                      fontSize: 13,
                      fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ],
    ),
  );
}
