import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './services/weather_provider.dart';
import './screens/search_history.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                try {
                  await weatherProvider.getWeather(cityController.text);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('City not found or network error'),
                    ),
                  );
                }
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            if (weatherProvider.weather != null) ...[
              Text(
                'Temperature: ${weatherProvider.temperature}° ${weatherProvider.unit}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Humidity: ${weatherProvider.weather!.humidity}%',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Wind Speed: ${weatherProvider.weather!.windSpeed} km/h',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Condition: ${weatherProvider.weather!.description}',
                style: TextStyle(fontSize: 20),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: weatherProvider.toggleUnit,
              child: Text('Toggle ${weatherProvider.unit == 'Celsius' ? 'Fahrenheit' : 'Celsius'}'),
            ),
          ],
        ),
      ),
    );
  }
}
