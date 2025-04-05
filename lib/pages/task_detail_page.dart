import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskDetailPage extends StatefulWidget {
  final Map<String, dynamic> task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final supabase = Supabase.instance.client;
  File? file;

  Future<void> pickMedia() async {
    final picker = ImagePicker();

    // Ask user to choose between Camera or Gallery
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Camera'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          TextButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text('Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (source == null) return;

    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        file = File(picked.path);
      });
    }
  }

  Future<void> markAsCompleted() async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a proof image first.')),
      );
      return;
    }

    final filePath = 'proofs/${DateTime.now().millisecondsSinceEpoch}_${file!.path.split('/').last}';
    final fileBytes = await file!.readAsBytes();

    await supabase.storage.from('proofs').uploadBinary(filePath, fileBytes);
    final publicUrl = supabase.storage.from('proofs').getPublicUrl(filePath);

    await supabase
        .from('claimed_tasks')
        .update({
      'status': 'Completed',
      'proof_url': publicUrl,
    }).eq('id', widget.task['id']);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task marked as completed!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    final imageUrl = task['image_url'] ?? '';
    final location = task['location'] ?? 'Unknown';
    final severity = task['severity'] ?? 'N/A';
    final prediction = task['prediction'] ?? 'N/A';
    final description = task['description'] ?? 'No description';
    final title = task['title'] ?? 'Task Detail';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            imageUrl.isNotEmpty
                ? Image.network(imageUrl, height: 200, fit: BoxFit.cover)
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text('No Image Available')),
            ),
            const SizedBox(height: 16),
            Text('📍 Location: $location', style: const TextStyle(fontSize: 16)),
            Text('🚨 Severity: $severity', style: const TextStyle(fontSize: 16)),
            Text('🔮 Prediction: $prediction', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('📝 Description:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(description),
            const SizedBox(height: 24),
            const Text('📷 Upload Proof of Completion:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            file != null
                ? Image.file(file!, height: 150)
                : const Text('No file selected.'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload),
              label: const Text('Select Image'),
              onPressed: pickMedia,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text('Mark as Completed'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: markAsCompleted,
            ),
          ],
        ),
      ),
    );
  }
}
