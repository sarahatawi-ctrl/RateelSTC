import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Domain/UseCases/get_surah_ayahs.dart';
import '../../Domain/UseCases/get_surah_list.dart';
import '../Providers/quran_text_provider.dart';
import 'reciters_screen.dart';
import 'surah_reading_screen.dart';

class QuranHubScreen extends StatelessWidget {
  const QuranHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (ctx) => QuranTextProvider(
        getSurahList: ctx.read<GetSurahList>(),
        getSurahAyahs: ctx.read<GetSurahAyahs>(),
      )..loadSurahList(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('القرآن الكريم'),
            backgroundColor: theme.appBarTheme.backgroundColor,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: 'قراءة'),
                Tab(text: 'استماع'),
              ],
            ),
          ),
          body: const TabBarView(children: [_SurahListTab(), RecitersScreen()]),
        ),
      ),
    );
  }
}

class _SurahListTab extends StatelessWidget {
  const _SurahListTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<QuranTextProvider>();

    if (provider.isLoadingList) {
      return const Center(child: CircularProgressIndicator());
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
        itemCount: provider.surahs.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: theme.dividerColor),
        itemBuilder: (context, index) {
          final surah = provider.surahs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                '${surah.number}',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            title: Text(
              surah.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${surah.isMeccan ? "مكية" : "مدنية"} • ${surah.ayahCount} آية',
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SurahReadingScreen(surah: surah),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
