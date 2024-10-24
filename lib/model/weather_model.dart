class Weather {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;

  Weather({required this.temperature, required this.humidity, required this.windSpeed, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['current']['temp_c'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_kph'],
      description: json['current']['condition']['text'],
    );
  }
}
