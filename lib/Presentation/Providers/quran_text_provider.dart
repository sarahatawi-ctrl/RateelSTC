import 'package:flutter/material.dart';
import '../../Domain/Entities/quran_ayah.dart';
import '../../Domain/Entities/quran_surah_meta.dart';
import '../../Domain/UseCases/get_surah_ayahs.dart';
import '../../Domain/UseCases/get_surah_list.dart';

class QuranTextProvider extends ChangeNotifier {
  final GetSurahList getSurahList;
  final GetSurahAyahs getSurahAyahs;

  QuranTextProvider({required this.getSurahList, required this.getSurahAyahs});

  List<QuranSurahMeta> surahs = [];
  bool isLoadingList = true;

  List<QuranAyah> ayahs = [];
  bool isLoadingAyahs = false;

  Future<void> loadSurahList() async {
    isLoadingList = true;
    notifyListeners();
    surahs = await getSurahList();
    isLoadingList = false;
    notifyListeners();
  }

  Future<void> loadAyahs(int number) async {
    isLoadingAyahs = true;
    ayahs = [];
    notifyListeners();
    ayahs = await getSurahAyahs(number);
    isLoadingAyahs = false;
    notifyListeners();
  }
}
