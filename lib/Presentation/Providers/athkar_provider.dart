import 'package:flutter/material.dart';
import '../../Domain/Entities/athkar_category.dart';
import '../../Domain/Entities/athkar_item.dart';
import '../../Domain/UseCases/get_athkar_category_content.dart';
import '../../Domain/UseCases/get_quick_athkar.dart';

class AthkarProvider extends ChangeNotifier {
  final GetQuickAthkar getQuickAthkar;
  final GetAthkarCategoryContent getAthkarCategoryContent;

  AthkarProvider({
    required this.getQuickAthkar,
    required this.getAthkarCategoryContent,
  });

  List<AthkarItem> items = [];
  List<int> remaining = [];
  bool isLoading = true;
  bool hasError = false;

  Future<void> loadQuick(AthkarQuickType type) =>
      _load(() => getQuickAthkar(type));

  Future<void> loadCategory(int id) =>
      _load(() => getAthkarCategoryContent(id));

  Future<void> _load(Future<List<AthkarItem>> Function() fetch) async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      items = await fetch();
      remaining = items.map((e) => e.repeat).toList();
    } catch (_) {
      hasError = true;
      items = [];
      remaining = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void tapItem(int index) {
    if (remaining[index] > 0) {
      remaining[index]--;
      notifyListeners();
    }
  }
}
