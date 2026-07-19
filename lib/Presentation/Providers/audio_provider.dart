import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../../Data/Services/audio_handler.dart';

class AudioProvider extends ChangeNotifier {
  MyAudioHandler? _handler;
  bool get isReady => _handler != null;
  MyAudioHandler get handler => _handler!;

  Future<void> init() async {
    if (_handler != null) return;

    _handler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.app.audio',
        androidNotificationChannelName: 'Quran Audio Playback',
        androidNotificationOngoing: true,
      ),
    );
    notifyListeners();
  }

  void playSurah(String url, String title, String reciter) {
    _handler?.playSurah(url, title, reciter);
  }

  void stopAndReset() {
    _handler?.pause();
    _handler?.seek(Duration.zero);
  }
}
