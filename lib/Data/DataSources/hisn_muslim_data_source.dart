import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/athkar_item_model.dart';

class HisnMuslimDataSource {
  final http.Client client;

  HisnMuslimDataSource(this.client);

  Future<List<AthkarItemModel>> fetchCategory(int id) async {
    final response = await client.get(
      Uri.parse('https://www.hisnmuslim.com/api/ar/$id.json'),
    );
    final body = utf8.decode(response.bodyBytes).replaceFirst('﻿', '');
    final data = json.decode(body);
    final items = (data as Map<String, dynamic>).values.first as List;

    return items.map((e) => AthkarItemModel.fromHisnMuslimJson(e)).toList();
  }
}
