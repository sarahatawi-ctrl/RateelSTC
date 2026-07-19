import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Domain/Entities/athkar_category.dart';
import '../../Domain/UseCases/get_prayer_times.dart';
import '../Providers/home_provider.dart';
import '../Widgets/section_header.dart';
import 'athkar_categories_screen.dart';
import 'athkar_list_screen.dart';
import 'quran_hub_screen.dart';

import '../Widgets/grid_item.dart';
import '../Widgets/responsive_grid.dart';
import '../Widgets/banner.dart';
import '../Widgets/rateel_info_button.dart';
import '../Widgets/prayer_header_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) =>
          HomeProvider(getPrayerTimes: ctx.read<GetPrayerTimes>())..init(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  void _openAthkar(BuildContext context, String title, AthkarQuickType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AthkarListScreen(title: title, quickType: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final home = context.watch<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: const Text(
          'الأذكار',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPrayerHeaderCard(
                  theme: theme,
                  now: home.currentTime,
                  cityName: home.cityName,
                  prayerTimes: home.prayerTimes,
                  isLoading: home.isLoading,
                ),

                const SizedBox(height: 24),

                buildSectionHeader('الأذكار', 'الكل', theme),

                const SizedBox(height: 16),

                buildResponsiveGrid(context, [
                  buildGridItem(
                    context,
                    'أذكار الصباح',
                    Icons.wb_sunny_outlined,
                    theme.colorScheme.primary,
                    onTap: () => _openAthkar(
                      context,
                      'أذكار الصباح',
                      AthkarQuickType.morning,
                    ),
                  ),
                  buildGridItem(
                    context,
                    'أذكار المساء',
                    Icons.wb_twilight_outlined,
                    theme.colorScheme.primary,
                    onTap: () => _openAthkar(
                      context,
                      'أذكار المساء',
                      AthkarQuickType.evening,
                    ),
                  ),
                  buildGridItem(
                    context,
                    'أذكار الصلاة',
                    Icons.mosque_outlined,
                    theme.colorScheme.primary,
                    onTap: () => _openAthkar(
                      context,
                      'أذكار الصلاة',
                      AthkarQuickType.afterPrayer,
                    ),
                  ),
                  buildGridItem(
                    context,
                    'أذكار النوم',
                    Icons.nightlight_round_outlined,
                    theme.colorScheme.primary,
                    onTap: () => _openAthkar(
                      context,
                      'أذكار النوم',
                      AthkarQuickType.sleep,
                    ),
                  ),
                ]),

                const SizedBox(height: 24),

                buildBanner(
                  'أذكار حصن المسلم',
                  theme,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AthkarCategoriesScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                buildSectionHeader('القرآن الكريم', '', theme),

                const SizedBox(height: 16),

                buildBanner(
                  'قراءة واستماع القرآن الكريم',
                  theme,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuranHubScreen()),
                    );
                  },
                ),

                const SizedBox(height: 24),

                buildRateelInfoButton(context, theme),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
