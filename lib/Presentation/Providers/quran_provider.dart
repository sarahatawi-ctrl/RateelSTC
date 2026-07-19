import 'package:flutter/material.dart';
import '../../Domain/Entities/reciter.dart';
import '../../Domain/Entities/surah.dart';
import '../../Domain/UseCases/get_reciters.dart';
import '../../Domain/UseCases/get_surahs.dart';
import '../../Domain/UseCases/search_reciters.dart';

class QuranProvider extends ChangeNotifier {
  final GetReciters getReciters;
  final GetSurahs getSurahs;
  final SearchReciters searchReciters;

  QuranProvider({
    required this.getReciters,
    required this.getSurahs,
    required this.searchReciters,
  });

  List<Reciter> reciters = [];
  List<Surah> surahs = [];
  List<Reciter> filteredReciters = [];
  bool isLoading = true;
  String searchQuery = '';

  Future<void> loadData() async {
    isLoading = true;
    notifyListeners();

    reciters = await getReciters();
    surahs = await getSurahs();
    filteredReciters = reciters;

    isLoading = false;
    notifyListeners();
  }

  void filter(String query) {
    searchQuery = query;
    filteredReciters = searchReciters(
      reciters: reciters,
      surahs: surahs,
      query: query,
    );
    notifyListeners();
  }

  List<Surah> surahsFor(Reciter reciter) =>
      surahs.where((s) => reciter.surahList.contains(s.id)).toList();
}
