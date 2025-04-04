import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int claimedTasks = 0;
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? '';
      });

      final doc = await _firestore.collection('engineers').doc(user.uid).get();
      if (doc.exists && doc.data()!.containsKey('claimedTasks')) {
        setState(() {
          claimedTasks = doc.data()!['claimedTasks'];
        });
      }
    }
  }

  void _logout() async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login'); // Adjust this route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Icon(Icons.account_circle, size: 80, color: Colors.blue),
          const SizedBox(height: 10),
          Text("Email: $email", style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text("Claimed Tasks: $claimedTasks", style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
