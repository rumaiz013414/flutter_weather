import 'package:flutter/foundation.dart';
import '../model/weather_model.dart';
import 'weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? weather;
  String unit = 'Celsius';

  Future<void> getWeather(String city) async {
    try {
      final weatherData = await WeatherService().fetchCurrentWeather(city);
      weather = Weather.fromJson(weatherData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  String get temperature {
    if (weather == null) return '';
    if (unit == 'Celsius') {
      return weather!.temperature.toStringAsFixed(1);
    } else {
      return ((weather!.temperature * 9 / 5) + 32).toStringAsFixed(1);
    }
  }

  void toggleUnit() {
    if (unit == 'Celsius') {
      unit = 'Fahrenheit';
    } else {
      unit = 'Celsius';
    }
    notifyListeners();
  }
}
