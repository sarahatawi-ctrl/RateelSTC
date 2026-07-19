import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../Domain/Entities/prayer_times.dart';
import '../../Domain/UseCases/get_prayer_times.dart';

const _riyadhLat = 24.7136;
const _riyadhLng = 46.6753;

class HomeProvider extends ChangeNotifier {
  final GetPrayerTimes getPrayerTimes;

  HomeProvider({required this.getPrayerTimes});

  DateTime currentTime = DateTime.now();
  String cityName = '...';
  PrayerTimes? prayerTimes;
  bool isLoading = true;
  Timer? _clockTimer;

  Future<void> init() async {
    _clockTimer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      currentTime = DateTime.now();
      notifyListeners();
    });

    double lat = _riyadhLat;
    double lng = _riyadhLng;

    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final position = await Geolocator.getCurrentPosition();
        lat = position.latitude;
        lng = position.longitude;

        final placemarks = await placemarkFromCoordinates(lat, lng);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          cityName = place.locality?.isNotEmpty == true
              ? place.locality!
              : (place.administrativeArea ?? 'موقعك الحالي');
        }
      } else {
        cityName = 'الرياض';
      }
    } catch (_) {
      cityName = 'الرياض';
    }

    try {
      prayerTimes = await getPrayerTimes(lat, lng);
    } catch (_) {
      prayerTimes = null;
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }
}
