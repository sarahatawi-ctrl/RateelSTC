import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/prayer_times_model.dart';

class AladhanDataSource {
  final http.Client client;

  AladhanDataSource(this.client);

  Future<PrayerTimesModel> fetchTimings(
    double latitude,
    double longitude,
  ) async {
    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';

    final response = await client.get(
      Uri.parse(
        'https://api.aladhan.com/v1/timings/$dateStr'
        '?latitude=$latitude&longitude=$longitude&method=4',
      ),
    );

    final data = json.decode(response.body);
    return PrayerTimesModel.fromJson(data['data'], now);
  }
}
