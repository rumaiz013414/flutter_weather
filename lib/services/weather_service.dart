import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '49d567cf405b462f85285319242410';
  final String currentWeatherUrl = 'https://api.weatherapi.com/v1/current.json';
  final String forecastUrl = 'https://api.weatherapi.com/v1/forecast.json';

  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    final url = Uri.parse('$currentWeatherUrl?key=$apiKey&q=$city&aqi=no');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch current weather');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherForecast(String city) async {
    final url =
        Uri.parse('$forecastUrl?key=$apiKey&q=$city&days=5&aqi=no&alerts=no');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch forecast');
    }
  }
}
