import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/reciter_model.dart';
import '../Models/surah_model.dart';

abstract class QuranRemoteDataSource {
  Future<List<SurahModel>> fetchSurahs();
  Future<List<ReciterModel>> fetchReciters();
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final http.Client client;

  QuranRemoteDataSourceImpl(this.client);

  @override
  Future<List<SurahModel>> fetchSurahs() async {
    final response = await client.get(
      Uri.parse('https://www.mp3quran.net/api/v3/suwar?language=ar'),
    );
    final data = json.decode(response.body);

    return (data['suwar'] as List).map((s) => SurahModel.fromJson(s)).toList();
  }

  @override
  Future<List<ReciterModel>> fetchReciters() async {
    final response = await client.get(
      Uri.parse('https://www.mp3quran.net/api/v3/reciters?language=ar'),
    );
    final data = json.decode(response.body);

    return (data['reciters'] as List)
        .map((r) => ReciterModel.fromJson(r))
        .toList();
  }
}
