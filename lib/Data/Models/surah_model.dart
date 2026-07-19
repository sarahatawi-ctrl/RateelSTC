import '../../Domain/Entities/surah.dart';

class SurahModel extends Surah {
  SurahModel({required super.id, required super.name});

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(id: json['id'], name: json['name']);
  }
}
