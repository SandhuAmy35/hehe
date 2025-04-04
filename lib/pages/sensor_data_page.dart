import 'package:flutter/material.dart';

class SensorDataPage extends StatelessWidget {
  final List<Map<String, dynamic>> sensorReadings = [
    {"type": "Vibration", "value": "High"},
    {"type": "Soil Movement", "value": "Medium"},
    {"type": "Corrosion", "value": "Severe"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: sensorReadings.map((sensor) {
        return ListTile(
          leading: Icon(Icons.sensors),
          title: Text("${sensor['type']}"),
          subtitle: Text("Status: ${sensor['value']}"),
        );
      }).toList(),
    );
  }
}
