import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

// ✅ Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

// Internal pages
import 'pages/reports_page.dart';
import 'pages/ai_analysis_page.dart';
import 'pages/sensor_data_page.dart';
import 'pages/map_page.dart';
import 'pages/task_status_page.dart';
import 'pages/profile_tab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ Initialize Supabase
  await Supabase.initialize(
    url: 'https://jvdxiugewixohnxgzten.supabase.co', // 🔁 Replace this
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2ZHhpdWdld2l4b2hueGd6dGVuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM4MzE1MzksImV4cCI6MjA1OTQwNzUzOX0.uv8cCXrb-IrniXnSwn3bRgyq3uHE3K0I2WcayWsXyxI',       // 🔁 Replace this
  );

  runApp(const EngineerApp());
}

class EngineerApp extends StatelessWidget {
  const EngineerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Engineer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
          centerTitle: true,
        ),
      ),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EngineerHomePage extends StatefulWidget {
  const EngineerHomePage({super.key});

  @override
  _EngineerHomePageState createState() => _EngineerHomePageState();
}

class _EngineerHomePageState extends State<EngineerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ReportsPage(),
    AIAnalysisPage(),
    SensorDataPage(),
    MapPage(),
    TaskStatusPage(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.report), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.analytics), label: 'AI'),
          NavigationDestination(icon: Icon(Icons.sensors), label: 'Sensors'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.task), label: 'Tasks'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
