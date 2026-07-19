class Surah {
  final int id;
  final String name;

  Surah({required this.id, required this.name});

  String getAudioUrl(String server) {
    final surahIdStr = id.toString().padLeft(3, '0');
    return "$server$surahIdStr.mp3";
  }
}
