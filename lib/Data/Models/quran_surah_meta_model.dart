import '../../Domain/Entities/quran_surah_meta.dart';

class QuranSurahMetaModel extends QuranSurahMeta {
  QuranSurahMetaModel({
    required super.number,
    required super.name,
    required super.englishName,
    required super.ayahCount,
    required super.isMeccan,
  });

  factory QuranSurahMetaModel.fromJson(Map<String, dynamic> json) {
    return QuranSurahMetaModel(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      ayahCount: json['numberOfAyahs'],
      isMeccan: json['revelationType'] == 'Meccan',
    );
  }
}
