import '../../Domain/Entities/reciter.dart';

class ReciterModel extends Reciter {
  ReciterModel({
    required super.id,
    required super.name,
    required super.server,
    required super.surahList,
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    final moshaf = json['moshaf'][0];
    return ReciterModel(
      id: json['id'],
      name: json['name'],
      server: moshaf['server'],
      surahList: (moshaf['surah_list'] as String)
          .split(',')
          .map(int.parse)
          .toList(),
    );
  }
}
