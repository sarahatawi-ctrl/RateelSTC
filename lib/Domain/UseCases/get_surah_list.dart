import '../Entities/quran_surah_meta.dart';
import '../Repositories/quran_text_repository.dart';

class GetSurahList {
  final QuranTextRepository repository;

  GetSurahList(this.repository);

  Future<List<QuranSurahMeta>> call() => repository.getSurahList();
}
