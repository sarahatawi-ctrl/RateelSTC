import '../Entities/reciter.dart';
import '../Entities/surah.dart';

abstract class QuranRepository {
  Future<List<Reciter>> getReciters();
  Future<List<Surah>> getSurahs();
}
