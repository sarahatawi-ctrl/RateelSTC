import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_service/audio_service.dart';
import '../Providers/audio_provider.dart';
import '../Providers/quran_provider.dart';

class RecitersScreen extends StatefulWidget {
  const RecitersScreen({super.key});

  @override
  State<RecitersScreen> createState() => _RecitersScreenState();
}

class _RecitersScreenState extends State<RecitersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AudioProvider>().init();
    context.read<QuranProvider>().loadData();
  }

  @override
  void dispose() {
    context.read<AudioProvider>().stopAndReset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quran = context.watch<QuranProvider>();
    final audio = context.watch<AudioProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('القراء'),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: quran.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: quran.filter,
                      decoration: InputDecoration(
                        hintText: 'ابحث عن قارئ أو سورة...',
                        prefixIcon: Icon(
                          Icons.search,
                          color: theme.colorScheme.primary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.cardColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: quran.filteredReciters.length,
                      itemBuilder: (context, index) {
                        final reciter = quran.filteredReciters[index];
                        final reciterSurahs = quran.surahsFor(reciter);

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.primary,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              reciter.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${reciter.surahList.length} سورة متاحة',
                            ),
                            children: reciterSurahs
                                .where(
                                  (s) =>
                                      s.name.contains(quran.searchQuery) ||
                                      reciter.name.contains(quran.searchQuery),
                                )
                                .map(
                                  (surah) => ListTile(
                                    title: Text(surah.name),
                                    trailing: const Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.green,
                                    ),
                                    onTap: () {
                                      if (!audio.isReady) return;
                                      final audioUrl = surah.getAudioUrl(
                                        reciter.server,
                                      );

                                      audio.playSurah(
                                        audioUrl,
                                        surah.name,
                                        reciter.name,
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'جاري تشغيل سورة ${surah.name} بصوت ${reciter.name}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: audio.isReady
          ? StreamBuilder<MediaItem?>(
              stream: audio.handler.mediaItem,
              builder: (context, snapshot) {
                final mediaItem = snapshot.data;
                if (mediaItem == null) return const SizedBox.shrink();

                return Container(
                  height: 120,
                  color: theme.colorScheme.primary,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mediaItem.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  mediaItem.artist ?? '',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          StreamBuilder<PlaybackState>(
                            stream: audio.handler.playbackState,
                            builder: (context, snapshot) {
                              final playing = snapshot.data?.playing ?? false;
                              return IconButton(
                                icon: Icon(
                                  playing ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: playing
                                    ? audio.handler.pause
                                    : audio.handler.play,
                              );
                            },
                          ),
                        ],
                      ),
                      StreamBuilder<PlaybackState>(
                        stream: audio.handler.playbackState,
                        builder: (context, snapshot) {
                          final position =
                              snapshot.data?.position ?? Duration.zero;
                          final duration = mediaItem.duration ?? Duration.zero;

                          return Slider(
                            min: 0,
                            max: duration.inMilliseconds.toDouble() > 0
                                ? duration.inMilliseconds.toDouble()
                                : 1,
                            value: position.inMilliseconds.toDouble().clamp(
                              0,
                              duration.inMilliseconds.toDouble() > 0
                                  ? duration.inMilliseconds.toDouble()
                                  : 1,
                            ),
                            onChanged: (value) {
                              audio.handler.seek(
                                Duration(milliseconds: value.toInt()),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
