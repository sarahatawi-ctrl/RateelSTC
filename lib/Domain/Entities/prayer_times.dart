class PrayerTimes {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final String hijriDate;
  final String hijriWeekday;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.hijriDate,
    required this.hijriWeekday,
  });

  List<MapEntry<String, DateTime>> get ordered => [
    MapEntry('الفجر', fajr),
    MapEntry('الشروق', sunrise),
    MapEntry('الظهر', dhuhr),
    MapEntry('العصر', asr),
    MapEntry('المغرب', maghrib),
    MapEntry('العشاء', isha),
  ];

  MapEntry<String, DateTime> nextPrayer(DateTime now) {
    for (final entry in ordered) {
      if (entry.value.isAfter(now)) return entry;
    }
    return MapEntry(
      ordered.first.key,
      ordered.first.value.add(const Duration(days: 1)),
    );
  }
}
