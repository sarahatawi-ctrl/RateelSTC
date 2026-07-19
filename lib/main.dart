import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Data/DataSources/aladhan_data_source.dart';
import 'Data/DataSources/hisn_muslim_data_source.dart';
import 'Data/DataSources/muslim_kit_athkar_data_source.dart';
import 'Data/DataSources/quran_remote_data_source.dart';
import 'Data/DataSources/quran_text_data_source.dart';
import 'Data/Repositories/athkar_repository_impl.dart';
import 'Data/Repositories/prayer_repository_impl.dart';
import 'Data/Repositories/quran_repository_impl.dart';
import 'Data/Repositories/quran_text_repository_impl.dart';
import 'Domain/UseCases/get_athkar_categories.dart';
import 'Domain/UseCases/get_athkar_category_content.dart';
import 'Domain/UseCases/get_prayer_times.dart';
import 'Domain/UseCases/get_quick_athkar.dart';
import 'Domain/UseCases/get_reciters.dart';
import 'Domain/UseCases/get_surah_ayahs.dart';
import 'Domain/UseCases/get_surah_list.dart';
import 'Domain/UseCases/get_surahs.dart';
import 'Domain/UseCases/search_reciters.dart';
import 'Presentation/Providers/audio_provider.dart';
import 'Presentation/Providers/quran_provider.dart';
import 'Presentation/Screens/home_screen.dart';
import 'Presentation/themes/app_theme.dart';

void main() {
  final httpClient = http.Client();

  final quranRepository = QuranRepositoryImpl(
    QuranRemoteDataSourceImpl(httpClient),
  );
  final athkarRepository = AthkarRepositoryImpl(
    MuslimKitAthkarDataSource(httpClient),
    HisnMuslimDataSource(httpClient),
  );
  final prayerRepository = PrayerRepositoryImpl(AladhanDataSource(httpClient));
  final quranTextRepository = QuranTextRepositoryImpl(
    QuranTextDataSource(httpClient),
  );

  runApp(
    AthkarApp(
      quranRepository: quranRepository,
      athkarRepository: athkarRepository,
      prayerRepository: prayerRepository,
      quranTextRepository: quranTextRepository,
    ),
  );
}

class AthkarApp extends StatelessWidget {
  final QuranRepositoryImpl quranRepository;
  final AthkarRepositoryImpl athkarRepository;
  final PrayerRepositoryImpl prayerRepository;
  final QuranTextRepositoryImpl quranTextRepository;

  const AthkarApp({
    super.key,
    required this.quranRepository,
    required this.athkarRepository,
    required this.prayerRepository,
    required this.quranTextRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GetQuickAthkar(athkarRepository)),
        Provider(create: (_) => GetAthkarCategoryContent(athkarRepository)),
        Provider(create: (_) => GetAthkarCategories(athkarRepository)),
        Provider(create: (_) => GetPrayerTimes(prayerRepository)),
        Provider(create: (_) => GetSurahList(quranTextRepository)),
        Provider(create: (_) => GetSurahAyahs(quranTextRepository)),

        ChangeNotifierProvider(
          create: (_) => QuranProvider(
            getReciters: GetReciters(quranRepository),
            getSurahs: GetSurahs(quranRepository),
            searchReciters: SearchReciters(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: MaterialApp(
        title: 'الاذكار',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.defaultTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
