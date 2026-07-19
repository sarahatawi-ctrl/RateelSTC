import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/quran_ayah_model.dart';
import '../Models/quran_surah_meta_model.dart';

class QuranTextDataSource {
  final http.Client client;

  QuranTextDataSource(this.client);

  Future<List<QuranSurahMetaModel>> fetchSurahList() async {
    final response = await client.get(
      Uri.parse('https://api.alquran.cloud/v1/surah'),
    );
    final data = json.decode(response.body);

    return (data['data'] as List)
        .map((e) => QuranSurahMetaModel.fromJson(e))
        .toList();
  }

  Future<List<QuranAyahModel>> fetchSurahAyahs(int number) async {
    final response = await client.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/$number/quran-uthmani'),
    );
    final data = json.decode(response.body);

    return (data['data']['ayahs'] as List)
        .map((e) => QuranAyahModel.fromJson(e))
        .toList();
  }
}
