import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(home: WeatherApp()));

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=mumbai&appid=3c97151c47f203334e308a7860ea8826&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load weather data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: fetchWeather),
        ],
      ),
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : errorMessage.isNotEmpty
                ? Text(errorMessage)
                : weatherData != null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weatherData!['main']['temp']}°C',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      weatherData!['weather'][0]['description'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text('Feels like: ${weatherData!['main']['feels_like']}°C'),
                    Text(
                      'H: ${weatherData!['main']['temp_max']}°C   '
                      'L: ${weatherData!['main']['temp_min']}°C',
                    ),
                  ],
                )
                : Text('No data available'),
      ),
    );
  }
}
