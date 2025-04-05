import 'package:flutter/material.dart';
import 'report_detail_page.dart'; // Import the detailed page

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary fake report data
    final List<Map<String, dynamic>> reportList = [
      {
        'title': 'Pothole on Main Street',
        'severity': 'High',
        'status': 'Pending',
        'imageUrl': 'https://via.placeholder.com/150',
        'location': 'Main Street, City Center',
        'description': 'Large pothole causing traffic issues near signal.',
        'prediction': 'May deepen by 30% in 5 days due to heavy traffic.',
      },
      {
        'title': 'Bridge Crack Reported',
        'severity': 'Medium',
        'status': 'In Progress',
        'imageUrl': 'https://via.placeholder.com/150',
        'location': 'River Bridge, Zone B',
        'description': 'Hairline cracks detected in bridge support.',
        'prediction': 'Expected to worsen if not sealed before monsoon.',
      },
      {
        'title': 'Road Erosion',
        'severity': 'Low',
        'status': 'Fixed',
        'imageUrl': 'https://via.placeholder.com/150',
        'location': 'Hill Road, Sector 9',
        'description': 'Mild erosion on road edges due to water flow.',
        'prediction': 'No further erosion expected post repair.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Damage Reports'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: reportList.length,
          itemBuilder: (context, index) {
            final report = reportList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReportDetailPage(report: report),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        report['imageUrl'],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report['title'],
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(report['location'], style: const TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildTag(context, 'Severity: ${report['severity']}', Colors.redAccent),
                              const SizedBox(width: 8),
                              _buildTag(
                                context,
                                'Status: ${report['status']}',
                                report['status'] == 'Fixed'
                                    ? Colors.green
                                    : report['status'] == 'In Progress'
                                    ? Colors.orange
                                    : Colors.blueGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
