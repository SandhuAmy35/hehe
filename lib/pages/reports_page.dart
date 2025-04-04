import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  final List<Map<String, String>> sampleReports = [
    {"location": "Bridge A", "severity": "High"},
    {"location": "Highway 17", "severity": "Medium"},
    {"location": "Overpass 5", "severity": "Low"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sampleReports.length,
      itemBuilder: (context, index) {
        var report = sampleReports[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text("Location: ${report['location']}"),
            subtitle: Text("Severity: ${report['severity']}"),
            trailing: ElevatedButton(
              child: Text('Claim'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task claimed!')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
