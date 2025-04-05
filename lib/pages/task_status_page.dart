import 'package:flutter/material.dart';
import 'task_detail_page.dart'; // You need to create this if not already.

class TaskStatusPage extends StatelessWidget {
  final List<Map<String, dynamic>> dummyTasks = [
    {
      'title': 'Bridge Crack – NH48',
      'severity': 'High',
      'status': 'Pending',
      'location': 'New Delhi, India',
      'imageUrl':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Cracked_concrete.jpg/640px-Cracked_concrete.jpg',
      'description': 'A large crack visible near the expansion joint.',
      'prediction': 'May worsen within 2 weeks',
    },
    {
      'title': 'Pothole – MG Road',
      'severity': 'Medium',
      'status': 'Pending',
      'location': 'Bangalore, India',
      'imageUrl':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Pothole_in_SF.jpg/640px-Pothole_in_SF.jpg',
      'description': 'Moderate-sized pothole near the left lane.',
      'prediction': 'Low risk, but monitor closely',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      body: ListView.builder(
        itemCount: dummyTasks.length,
        itemBuilder: (context, index) {
          final task = dummyTasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Image.network(
                task['imageUrl'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(task['title']),
              subtitle: Text('${task['location']} • ${task['severity']}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskDetailPage(task: task),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
