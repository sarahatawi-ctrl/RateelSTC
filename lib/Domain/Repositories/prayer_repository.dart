import '../Entities/prayer_times.dart';

abstract class PrayerRepository {
  Future<PrayerTimes> getTimings(double latitude, double longitude);
}
