import '../../Domain/Entities/prayer_times.dart';
import '../../Domain/Repositories/prayer_repository.dart';
import '../DataSources/aladhan_data_source.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final AladhanDataSource dataSource;

  PrayerRepositoryImpl(this.dataSource);

  @override
  Future<PrayerTimes> getTimings(double latitude, double longitude) =>
      dataSource.fetchTimings(latitude, longitude);
}
