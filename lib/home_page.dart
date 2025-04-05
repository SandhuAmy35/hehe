import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'pages/report_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🚧 InfraCare Engineer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Predict. Prevent. Preserve.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Infrastructure Health Overview
              const Text(
                'Infrastructure Health Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _PieCard(title: 'Potholes', percentage: 40, color: Colors.orange),
                  _PieCard(title: 'Cracks', percentage: 25, color: Colors.red),
                  _PieCard(title: 'Stable', percentage: 35, color: Colors.green),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Reports
              const Text(
                'Recent Reports',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              _RecentReportCard(
                imageUrl: 'https://i.imgur.com/Fh7XVYY.jpg',
                title: 'Bridge Crack - Sector 21',
                severity: 'High',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportDetailPage(
                        report: {
                          'imageUrl': 'https://i.imgur.com/Fh7XVYY.jpg',
                          'title': 'Bridge Crack - Sector 21',
                          'severity': 'High',
                          'location': 'Sector 21, City A',
                          'status': 'Unclaimed',
                          'description': 'Large crack on bridge pillar causing structural concerns.',
                          'prediction': 'Could lead to collapse in 2 weeks if ignored.',
                        },
                      ),
                    ),
                  );
                },
              ),

              _RecentReportCard(
                imageUrl: 'https://i.imgur.com/JbM2kQo.jpg',
                title: 'Pothole - Main Road',
                severity: 'Medium',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportDetailPage(
                        report: {
                          'imageUrl': 'https://i.imgur.com/JbM2kQo.jpg',
                          'title': 'Pothole - Main Road',
                          'severity': 'Medium',
                          'location': 'Main Road, City B',
                          'status': 'Unclaimed',
                          'description': 'Medium-sized pothole causing vehicle damage.',
                          'prediction': 'Worsening expected in 4 days due to rains.',
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PieCard extends StatelessWidget {
  final String title;
  final int percentage;
  final Color color;

  const _PieCard({
    required this.title,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: percentage.toDouble(),
                      color: color,
                      radius: 25,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: (100 - percentage).toDouble(),
                      color: Colors.grey.shade200,
                      radius: 25,
                      showTitle: false,
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 18,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text('$percentage%', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _RecentReportCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String severity;
  final VoidCallback onTap;

  const _RecentReportCard({
    required this.imageUrl,
    required this.title,
    required this.severity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(title),
                subtitle: Text('Severity: $severity'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
