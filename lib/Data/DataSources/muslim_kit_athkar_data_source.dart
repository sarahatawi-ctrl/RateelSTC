import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/athkar_item_model.dart';

class MuslimKitAthkarDataSource {
  final http.Client client;

  MuslimKitAthkarDataSource(this.client);

  static const _base = 'https://ahegazy.github.io/muslimKit/json';

  Future<List<AthkarItemModel>> fetchMorning() => _fetch('azkar_sabah');
  Future<List<AthkarItemModel>> fetchEvening() => _fetch('azkar_massa');
  Future<List<AthkarItemModel>> fetchAfterPrayer() =>
      _fetch('PostPrayer_azkar');

  Future<List<AthkarItemModel>> _fetch(String file) async {
    final response = await client.get(Uri.parse('$_base/$file.json'));
    final data = json.decode(utf8.decode(response.bodyBytes));

    return (data['content'] as List)
        .map((e) => AthkarItemModel.fromMuslimKitJson(e))
        .toList();
  }
}
