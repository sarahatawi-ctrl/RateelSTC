import '../../Domain/Entities/quran_ayah.dart';

class QuranAyahModel extends QuranAyah {
  QuranAyahModel({required super.number, required super.text});

  factory QuranAyahModel.fromJson(Map<String, dynamic> json) {
    return QuranAyahModel(
      number: json['numberInSurah'],
      text: (json['text'] as String).replaceFirst('﻿', ''),
    );
  }
}
