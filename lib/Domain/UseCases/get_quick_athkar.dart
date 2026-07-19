import '../Entities/athkar_category.dart';
import '../Entities/athkar_item.dart';
import '../Repositories/athkar_repository.dart';

class GetQuickAthkar {
  final AthkarRepository repository;

  GetQuickAthkar(this.repository);

  Future<List<AthkarItem>> call(AthkarQuickType type) =>
      repository.getQuickCategory(type);
}
