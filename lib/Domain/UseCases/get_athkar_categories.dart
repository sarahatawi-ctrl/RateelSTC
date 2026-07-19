import '../Entities/athkar_category.dart';
import '../Repositories/athkar_repository.dart';

class GetAthkarCategories {
  final AthkarRepository repository;

  GetAthkarCategories(this.repository);

  List<AthkarCategoryMeta> call() => repository.getAllCategories();
}
