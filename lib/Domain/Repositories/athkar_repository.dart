import '../Entities/athkar_category.dart';
import '../Entities/athkar_item.dart';

abstract class AthkarRepository {
  Future<List<AthkarItem>> getQuickCategory(AthkarQuickType type);
  List<AthkarCategoryMeta> getAllCategories();
  Future<List<AthkarItem>> getCategoryContent(int id);
}
