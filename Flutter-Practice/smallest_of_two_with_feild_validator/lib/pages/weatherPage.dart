import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String errorMessage = "";

  Future<void> getWeatherData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=mumbai&appid=3c97151c47f203334e308a7860ea8826&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        errorMessage = 'Failed to load weather data';
        isLoading = false;
      }
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todays Weather')),
      body: Expanded(
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Text(errorMessage)
                : weatherData != null
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weatherData!['main']['temp']} C',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
                : Text('No Data Found'),
      ),
    );
  }
}
