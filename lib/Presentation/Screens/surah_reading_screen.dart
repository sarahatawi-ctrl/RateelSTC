import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Domain/Entities/quran_surah_meta.dart';
import '../../Domain/UseCases/get_surah_ayahs.dart';
import '../../Domain/UseCases/get_surah_list.dart';
import '../Providers/quran_text_provider.dart';

class SurahReadingScreen extends StatelessWidget {
  final QuranSurahMeta surah;

  const SurahReadingScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => QuranTextProvider(
        getSurahList: ctx.read<GetSurahList>(),
        getSurahAyahs: ctx.read<GetSurahAyahs>(),
      )..loadAyahs(surah.number),
      child: _SurahReadingBody(surah: surah),
    );
  }
}

class _SurahReadingBody extends StatelessWidget {
  final QuranSurahMeta surah;

  const _SurahReadingBody({required this.surah});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<QuranTextProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(surah.name),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: provider.isLoadingAyahs
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (surah.number != 9)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    Text.rich(
                      TextSpan(
                        children: provider.ayahs
                            .map<InlineSpan>(
                              (ayah) => TextSpan(
                                children: [
                                  TextSpan(text: '${ayah.text} '),
                                  TextSpan(
                                    text: '﴿${ayah.number}﴾ ',
                                    style: TextStyle(
                                      color: theme.colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 22,
                        height: 2.2,
                        color: theme.textTheme.bodyLarge?.color ?? Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
