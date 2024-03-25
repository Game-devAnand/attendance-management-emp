import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  //my widget page //Users list page
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<UsersListPage> {
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
        title: Text('Administration Desk'),
        backgroundColor: Color.fromARGB(255, 54, 180, 186),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _userService.getStudentUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No employees found.'));
          } else {
            List<Map<String, dynamic>> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> user = users[index];
                bool isDisabled =
                    user['isDisabled'] ?? false; // Check if user is disabled

                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 3.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text(
                        user['userName'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user['userEmail'] ?? ''),
                          SizedBox(height: 8.0),
                          Text(
                            'Due Amount: \₹${(user['userDueAmount'] ?? 0.0).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 54, 180, 186)),
                          ),
                        ],
                      ),
                      trailing: Switch(
                        value:
                            !isDisabled, // Invert value for better user understanding
                        onChanged: (newValue) {
                          _userService.updateUserDisabledStatus(
                              user['userId'], !newValue);
                        },
                      ),
                      onTap: () {
                        // Add any additional functionality when tapping on a user
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('attendifyUsers');

  Stream<List<Map<String, dynamic>>> getStudentUsersStream() {
    return _usersCollection
        .where('userRole', isEqualTo: 'employee')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  Future<void> updateUserDisabledStatus(String userId, bool isDisabled) {
    return _usersCollection.doc(userId).update({'isDisabled': isDisabled});
  }
}




/*  setState(() {
                      if (_tappedCardIndex == index) {
                        // Reset color if the same card is tapped again
                        _tappedCardIndex = -1;
                        _tappedCardColor = const Color.fromARGB(255, 192, 213, 230);
                      } else {
                        _tappedCardIndex = index;
                        _tappedCardColor = Color.fromARGB(
                            255, 191, 200, 231); // Change color when tapped
                      }
                    });



                     color: _tappedCardIndex == index
                        ? _tappedCardColor
                        : Colors.blue,
                         int _tappedCardIndex = -1; // Initialize to an invalid index
  Color _tappedCardColor = Colors.blue; // Initial color for untapped cards*/