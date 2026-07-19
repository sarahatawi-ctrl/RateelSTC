import '../Entities/surah.dart';
import '../Repositories/quran_repository.dart';

class GetSurahs {
  final QuranRepository repository;

  GetSurahs(this.repository);

  Future<List<Surah>> call() => repository.getSurahs();
}
