/*import 'dart:async';

import 'package:attendify_1/admin_window/user_requestpage.dart';
import 'package:attendify_1/admin_window/users_Listpage.dart';
import 'package:attendify_1/disable_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  void initState() {
    super.initState();
    getUserRole();
    _userSubscription = FirebaseFirestore.instance
        .collection('attendifyUsers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      setState(() {
      //  _isDisabled = snapshot['isDisabled'] ?? false;
      });
    });
  }

  //bool _isDisabled = false;
  late StreamSubscription<DocumentSnapshot> _userSubscription;

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;

  int _selectedIndex = 0;

  int index = 0;

  Future<int?> getUserRole() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('attendifyUsers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        if (userDoc['userRole'] == 'employee') {
          index = 0;
        } else if (userDoc['userRole'] == 'admin') {
          index = 1;
        }
      });

      return index;
    } else {
      return null;
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const MyWidget(),
    const UserRequestPage(),
    // const RequestStatusPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white10,
      //   title: Text('BusBoard'),
      // ),
      body: _isDisabled
          ? DisabledUserScreen()
          : index == 0
              ? _widgetOptions.elementAt(_selectedIndex)
              : MyWidget(),
      //importantt
      bottomNavigationBar: index == 0
          ? SnakeNavigationBar.color(
              behaviour: snakeBarStyle,
              snakeShape: snakeShape,
              shape: bottomBarShape,
              padding: padding,

              ///configuration for SnakeNavigationBar.color
              snakeViewColor: selectedColor,
              selectedItemColor:
                  snakeShape == SnakeShape.indicator ? selectedColor : null,
              unselectedItemColor: unselectedColor,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.file_open,
                  ),
                  label: 'UsersList',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'Requests',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'Requests Status',
                ),
              ],
            )
          : null,
    );
  }
}*/
/*import 'dart:async';

import 'package:attendify_1/admin_window/user_requestpage.dart';
import 'package:attendify_1/admin_window/users_Listpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  late StreamSubscription<DocumentSnapshot> _userSubscription;

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;

  int _selectedIndex = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('attendifyUsers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        if (userDoc['userRole'] == 'employee') {
          index = 0;
        } else if (userDoc['userRole'] == 'admin') {
          index = 1;
        }
      });
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const MyWidget(),
    const UserRequestPage(),
    //const RequestStatusPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: index == 0 ? _widgetOptions.elementAt(_selectedIndex) : MyWidget(),
      bottomNavigationBar: index == 0
          ? SnakeNavigationBar.color(
              behaviour: snakeBarStyle,
              snakeShape: snakeShape,
              shape: bottomBarShape,
              padding: padding,
              snakeViewColor: selectedColor,
              selectedItemColor:
                  snakeShape == SnakeShape.indicator ? selectedColor : null,
              unselectedItemColor: unselectedColor,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.file_open,
                  ),
                  label: 'UsersList',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: 'Requests',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.info),
                //   label: 'Requests Status',
                // ),
              ],
            )
          : null,
    );
  }
}*/
import 'dart:async';

import 'package:attendify_1/admin_window/users_Listpage.dart';
import 'package:attendify_1/admin_window/view_requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  late StreamSubscription<DocumentSnapshot> _userSubscription;

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Call the function to get user role when the widget initializes
    getUserRole();
  }

  Future<void> getUserRole() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('attendifyUsers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        // Set the index based on the user's role
        if (userDoc['userRole'] == 'employee') {
          _selectedIndex = 0;
        } else if (userDoc['userRole'] == 'admin') {
          _selectedIndex = 1;
        }
      });
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const UsersListPage(),
    ViewLeaveRequestsPage(),
    // Add more pages if needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      // Update the selected index when an item is tapped
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'User Requests',
          ),
          // Add more items if needed
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Define your admin window pages here
    // For example:
    Container(child: Center(child: Text('Users List Page'))),
    Container(child: Center(child: Text('User Requests Page'))),
    // Add more pages as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour:
            SnakeBarBehaviour.floating, // You can adjust the behavior as needed
        snakeShape: SnakeShape.indicator,
        snakeViewColor: Colors.blue, // Adjust colors as needed
        selectedItemColor: Colors.black, // Adjust colors as needed
        unselectedItemColor: Colors.grey, // Adjust colors as needed
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: 'User Requests',
          ),
          // Add more items as needed
        ],
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Define your admin window pages here
    // For example:
    Container(child: Center(child: Text('UsersListPage'))),
    Container(child: Center(child: Text('ViewLeaveRequestsPage'))),
    // Add more pages as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CrystalNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CrystalNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.people, 'Users List', 0),
          _buildNavItem(Icons.request_page, 'User Requests', 1),
          // Add more items as needed
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}*/
