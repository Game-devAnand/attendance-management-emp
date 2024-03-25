import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();

  Future<void> _submitLeaveRequest() async {
    try {
      await FirebaseFirestore.instance.collection('leave_requests').add({
        'branch': _branchController.text,
        'reason': _reasonController.text,
        'email': _emailController.text,
        'description': _descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'Status': 'pending...',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: const Text('Leave request submitted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error submitting leave request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit leave request. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reason for leave:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your reason for leave',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email address',
              ),
            ),
            TextField(
              controller: _branchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Branch Name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description (Optional):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter any additional information (optional)',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitLeaveRequest,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
