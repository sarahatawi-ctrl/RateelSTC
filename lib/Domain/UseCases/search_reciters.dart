import '../Entities/reciter.dart';
import '../Entities/surah.dart';

class SearchReciters {
  List<Reciter> call({
    required List<Reciter> reciters,
    required List<Surah> surahs,
    required String query,
  }) {
    if (query.isEmpty) return reciters;

    return reciters.where((reciter) {
      final nameMatch = reciter.name.contains(query);

      final surahMatch = surahs
          .where((s) => reciter.surahList.contains(s.id))
          .any((s) => s.name.contains(query));

      return nameMatch || surahMatch;
    }).toList();
  }
}
