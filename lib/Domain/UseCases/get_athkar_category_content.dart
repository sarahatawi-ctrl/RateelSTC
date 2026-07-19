import '../Entities/athkar_item.dart';
import '../Repositories/athkar_repository.dart';

class GetAthkarCategoryContent {
  final AthkarRepository repository;

  GetAthkarCategoryContent(this.repository);

  Future<List<AthkarItem>> call(int id) => repository.getCategoryContent(id);
}
