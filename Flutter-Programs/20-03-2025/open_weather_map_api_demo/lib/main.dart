import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CurrentWeatherPage());
  }
}

class Weather {
  final double? temp;
  final double? feelsLike;
  final double? low;
  final double? high;
  final String? description;

  Weather({this.temp, this.feelsLike, this.low, this.high, this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Data')),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot != null) {
              this._weather = snapshot.data;
            }
            return weatherBox(_weather!);
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }
}

Widget weatherBox(Weather _weather) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text("${_weather.temp}°C"),
      Text("${_weather.description}"),
      Text("Feels:${_weather.feelsLike}°C"),
      Text("H:${_weather.high}°C    L:${_weather.low}°C"),
    ],
  );
}

Future getCurrentWeather() async {
  Weather? weather;
  String city = "mumbai";
  String apiKey = "3c97151c47f203334e308a7860ea8826";
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }
  return weather;
}
