import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_status_page.dart';

class ReportDetailPage extends StatelessWidget {
  final Map<String, dynamic> report;

  const ReportDetailPage({super.key, required this.report});

  void claimTask(BuildContext context) async {
    final supabase = Supabase.instance.client;

    try {
      if (report['title'] == null ||
          report['imageUrl'] == null ||
          report['severity'] == null ||
          report['location'] == null ||
          report['description'] == null ||
          report['prediction'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Missing report data.')),
        );
        return;
      }

      final insertData = {
        'title': report['title'],
        'image_url': report['imageUrl'],
        'severity': report['severity'],
        'location': report['location'],
        'status': 'In Progress',
        'description': report['description'],
        'prediction': report['prediction'],
        'claimed_at': DateTime.now().toIso8601String(),
      };

      final response = await supabase.from('claimed_tasks').insert(insertData);

      if (response == null) {
        throw Exception("Insert failed, no response.");
      }

      // Show success dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Task Claimed!'),
          content: const Text('The report has been added to your task list.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskStatusPage(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error claiming task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report['title'] ?? 'Report Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (report['imageUrl'] != null)
              Image.network(
                report['imageUrl'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),

            Text(
              report['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              report['location'] ?? 'Unknown Location',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Chip(
                  label: Text('Severity: ${report['severity'] ?? 'N/A'}'),
                  backgroundColor: Colors.red.shade100,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('Status: ${report['status'] ?? 'Reported'}'),
                  backgroundColor: Colors.blue.shade100,
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(report['description'] ?? 'No description'),
            const SizedBox(height: 12),

            const Text(
              'Prediction',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(report['prediction'] ?? 'No prediction'),
            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.assignment_turned_in),
                label: const Text('Claim Report'),
                onPressed: () => claimTask(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
