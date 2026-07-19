import '../../Domain/Entities/prayer_times.dart';

class PrayerTimesModel extends PrayerTimes {
  PrayerTimesModel({
    required super.fajr,
    required super.sunrise,
    required super.dhuhr,
    required super.asr,
    required super.maghrib,
    required super.isha,
    required super.hijriDate,
    required super.hijriWeekday,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json, DateTime day) {
    final timings = json['timings'] as Map<String, dynamic>;
    final hijri = json['date']['hijri'];

    DateTime parse(String key) {
      final parts = (timings[key] as String).split(':');
      return DateTime(
        day.year,
        day.month,
        day.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }

    return PrayerTimesModel(
      fajr: parse('Fajr'),
      sunrise: parse('Sunrise'),
      dhuhr: parse('Dhuhr'),
      asr: parse('Asr'),
      maghrib: parse('Maghrib'),
      isha: parse('Isha'),
      hijriDate: '${hijri['day']} ${hijri['month']['ar']} ${hijri['year']}',
      hijriWeekday: hijri['weekday']['ar'],
    );
  }
}
