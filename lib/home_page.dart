import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 Title
              const Text(
                'Engineer Dashboard',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // 📊 Infrastructure Health Pie Charts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _PieChartCard(title: 'Bridges', percent: 70),
                  _PieChartCard(title: 'Roads', percent: 50),
                  _PieChartCard(title: 'Pipes', percent: 85),
                ],
              ),

              const SizedBox(height: 24),

              // 📝 Recent Reports Section
              const Text(
                'Recent Reports',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _ReportCard(
                      title: "Pothole - Sector 9",
                      imageUrl: "https://via.placeholder.com/150",
                      severity: "High",
                    ),
                    _ReportCard(
                      title: "Crack on Bridge",
                      imageUrl: "https://via.placeholder.com/150",
                      severity: "Medium",
                    ),
                    _ReportCard(
                      title: "Corroded Pipe",
                      imageUrl: "https://via.placeholder.com/150",
                      severity: "Low",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🔗 Navigation Shortcuts
              const Text(
                'Quick Access',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _NavButton(label: 'AI Analysis', icon: Icons.analytics, onTap: () {/* TODO */}),
                  _NavButton(label: 'Sensors', icon: Icons.sensors, onTap: () {/* TODO */}),
                  _NavButton(label: 'Map', icon: Icons.map, onTap: () {/* TODO */}),
                  _NavButton(label: 'Tasks', icon: Icons.task, onTap: () {/* TODO */}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🌈 Pie Chart Widget
class _PieChartCard extends StatelessWidget {
  final String title;
  final double percent;

  const _PieChartCard({required this.title, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.blue,
                  value: percent,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Colors.grey[300],
                  value: 100 - percent,
                  showTitle: false,
                  radius: 25,
                ),
              ],
              centerSpaceRadius: 18,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// 📝 Report Card Widget
class _ReportCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String severity;

  const _ReportCard({required this.title, required this.imageUrl, required this.severity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text("Severity: $severity", style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🚀 Navigation Button Widget
class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        avatar: Icon(icon, size: 20),
        label: Text(label),
        backgroundColor: Colors.blue[50],
      ),
    );
  }
}
