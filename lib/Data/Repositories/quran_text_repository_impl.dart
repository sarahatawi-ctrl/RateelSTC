import '../../Domain/Entities/quran_ayah.dart';
import '../../Domain/Entities/quran_surah_meta.dart';
import '../../Domain/Repositories/quran_text_repository.dart';
import '../DataSources/quran_text_data_source.dart';

class QuranTextRepositoryImpl implements QuranTextRepository {
  final QuranTextDataSource dataSource;

  List<QuranSurahMeta>? _cachedList;
  final Map<int, List<QuranAyah>> _ayahCache = {};

  QuranTextRepositoryImpl(this.dataSource);

  @override
  Future<List<QuranSurahMeta>> getSurahList() async {
    _cachedList ??= await dataSource.fetchSurahList();
    return _cachedList!;
  }

  @override
  Future<List<QuranAyah>> getSurahAyahs(int number) async {
    if (_ayahCache.containsKey(number)) return _ayahCache[number]!;
    final ayahs = await dataSource.fetchSurahAyahs(number);
    _ayahCache[number] = ayahs;
    return ayahs;
  }
}
