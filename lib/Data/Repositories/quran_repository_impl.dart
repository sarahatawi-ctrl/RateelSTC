import '../../Domain/Entities/reciter.dart';
import '../../Domain/Entities/surah.dart';
import '../../Domain/Repositories/quran_repository.dart';
import '../DataSources/quran_remote_data_source.dart';

class QuranRepositoryImpl implements QuranRepository {
  final QuranRemoteDataSource remoteDataSource;

  List<Reciter>? _cachedReciters;
  List<Surah>? _cachedSurahs;

  QuranRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Reciter>> getReciters() async {
    _cachedReciters ??= await remoteDataSource.fetchReciters();
    return _cachedReciters!;
  }

  @override
  Future<List<Surah>> getSurahs() async {
    _cachedSurahs ??= await remoteDataSource.fetchSurahs();
    return _cachedSurahs!;
  }
}
