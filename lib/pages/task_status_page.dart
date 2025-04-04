import 'package:flutter/material.dart';

class TaskStatusPage extends StatefulWidget {
  @override
  _TaskStatusPageState createState() => _TaskStatusPageState();
}

class _TaskStatusPageState extends State<TaskStatusPage> {
  String _status = "Pending";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Current Status: $_status", style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        ElevatedButton(
          child: Text("Set to In Progress"),
          onPressed: () => setState(() => _status = "In Progress"),
        ),
        ElevatedButton(
          child: Text("Set to Fixed"),
          onPressed: () => setState(() => _status = "Fixed"),
        ),
      ],
    );
  }
}
