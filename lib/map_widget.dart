import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng? _currentPosition;
  String _locationError = '';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Check if GPS is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _locationError = 'GPS is disabled. Enable it in settings.');
      return;
    }

    // ✅ Check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _locationError = 'Location permission denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _locationError = 'Location permission permanently denied.');
      return;
    }

    // ✅ Get current position
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() => _locationError = 'Failed to get location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Show loading while getting location
    if (_currentPosition == null && _locationError.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // ❌ Show error message if GPS is off or permission denied
    if (_locationError.isNotEmpty) {
      return Center(child: Text(_locationError, style: const TextStyle(color: Colors.red)));
    }

    // ✅ Show map when location is available
    return FlutterMap(
      options: MapOptions(
        initialCenter: _currentPosition!,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'], // Ensures backup servers are used
          userAgentPackageName: 'com.example.engineer_app_frontend',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _currentPosition!,
              width: 40,
              height: 40,
              child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}
