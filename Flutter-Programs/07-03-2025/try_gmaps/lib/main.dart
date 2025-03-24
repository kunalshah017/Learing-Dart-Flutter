import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? _mapController;

  final LatLng _center = const LatLng(19.075983, 72.877655);

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 10.0),
          ),
        ),
      ),
    );
  }
}
