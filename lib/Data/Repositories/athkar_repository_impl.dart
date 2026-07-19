import '../../Domain/Entities/athkar_category.dart';
import '../../Domain/Entities/athkar_item.dart';
import '../../Domain/Repositories/athkar_repository.dart';
import '../DataSources/hisn_muslim_categories.dart';
import '../DataSources/hisn_muslim_data_source.dart';
import '../DataSources/muslim_kit_athkar_data_source.dart';

const _sleepCategoryId = 28;

class AthkarRepositoryImpl implements AthkarRepository {
  final MuslimKitAthkarDataSource muslimKitSource;
  final HisnMuslimDataSource hisnMuslimSource;

  final Map<int, List<AthkarItem>> _cache = {};

  AthkarRepositoryImpl(this.muslimKitSource, this.hisnMuslimSource);

  @override
  Future<List<AthkarItem>> getQuickCategory(AthkarQuickType type) {
    switch (type) {
      case AthkarQuickType.morning:
        return muslimKitSource.fetchMorning();
      case AthkarQuickType.evening:
        return muslimKitSource.fetchEvening();
      case AthkarQuickType.afterPrayer:
        return muslimKitSource.fetchAfterPrayer();
      case AthkarQuickType.sleep:
        return getCategoryContent(_sleepCategoryId);
    }
  }

  @override
  List<AthkarCategoryMeta> getAllCategories() => hisnMuslimCategories;

  @override
  Future<List<AthkarItem>> getCategoryContent(int id) async {
    if (_cache.containsKey(id)) return _cache[id]!;
    final items = await hisnMuslimSource.fetchCategory(id);
    _cache[id] = items;
    return items;
  }
}
