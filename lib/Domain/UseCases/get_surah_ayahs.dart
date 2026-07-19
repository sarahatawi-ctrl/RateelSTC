import '../Entities/quran_ayah.dart';
import '../Repositories/quran_text_repository.dart';

class GetSurahAyahs {
  final QuranTextRepository repository;

  GetSurahAyahs(this.repository);

  Future<List<QuranAyah>> call(int number) => repository.getSurahAyahs(number);
}
