import '../Entities/prayer_times.dart';
import '../Repositories/prayer_repository.dart';

class GetPrayerTimes {
  final PrayerRepository repository;

  GetPrayerTimes(this.repository);

  Future<PrayerTimes> call(double latitude, double longitude) =>
      repository.getTimings(latitude, longitude);
}
