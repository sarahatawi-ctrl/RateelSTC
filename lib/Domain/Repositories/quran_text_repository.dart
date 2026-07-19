import '../Entities/quran_ayah.dart';
import '../Entities/quran_surah_meta.dart';

abstract class QuranTextRepository {
  Future<List<QuranSurahMeta>> getSurahList();
  Future<List<QuranAyah>> getSurahAyahs(int number);
}
