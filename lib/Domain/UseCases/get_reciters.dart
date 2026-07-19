import '../Entities/reciter.dart';
import '../Repositories/quran_repository.dart';

class GetReciters {
  final QuranRepository repository;

  GetReciters(this.repository);

  Future<List<Reciter>> call() => repository.getReciters();
}
