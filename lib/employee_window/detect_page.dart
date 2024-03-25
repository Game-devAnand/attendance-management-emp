import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({Key? key}) : super(key: key);

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final CollectionReference _userDetectionCollection =
      FirebaseFirestore.instance.collection('userDetection');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Lottie.asset('assets/icons/animationtwo.json',
                height: 200, width: 200),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FingerPrint Authentication',
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 48, 123, 185)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _authenticateAndStoreDetection(true),
                    child: Text('Time In'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _authenticateAndStoreDetection(false),
                    child: Text('Time Out'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Lottie.asset(
                    'assets/icons/Animation - 1711099955402.json',
                    height: 200,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticateAndStoreDetection(bool timeIn) async {
    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to record time ${timeIn ? 'in' : 'out'}',
        // useErrorDialogs: true,
        // stickyAuth: true,
      );

      if (isAuthenticated) {
        DateTime now = DateTime.now();
        String? userId =
            FirebaseAuth.instance.currentUser?.uid; // user ID logic

        await _userDetectionCollection.add({
          'userId': userId,
          'time': now,
          'type': timeIn ? 'Time In' : 'Time Out',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Detection recorded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
