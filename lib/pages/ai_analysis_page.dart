import 'package:flutter/material.dart';

class AIAnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AI Predictive Analysis", style: TextStyle(fontSize: 22)),
          SizedBox(height: 20),
          Icon(Icons.analytics, size: 80, color: Colors.blue),
          SizedBox(height: 10),
          Text("Damage severity likely to increase in 10 days."),
        ],
      ),
    );
  }
}
