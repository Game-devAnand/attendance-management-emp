/*import 'package:attendify_1/constants.dart';
import 'package:attendify_1/firebase_options.dart';
import 'package:attendify_1/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: defaultPropertyBackgroundColour,
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )),
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Homepage();
        }
        return SignInScreen(
          subtitleBuilder: (context, action) {
            final actionText = switch (action) {
              AuthAction.signIn => 'Please sign in to continue.',
              AuthAction.signUp => 'Please create an account to continue',
              _ => throw Exception('Invalid action: $action'),
            };

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('Welcome to Attendify! $actionText.'),
            );
          },
          footerBuilder: (context, action) {
            final actionText = switch (action) {
              AuthAction.signIn => 'signing in',
              AuthAction.signUp => 'registering',
              _ => throw Exception('Invalid action: $action'),
            };

            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                /*CupertinoSlidingSegmentedControl(
                  groupValue: segmentedControlGroupValue,
                   children: myTabs,
                      onValueChanged: (i) {
                      setState(() {
                       // segmentedControlGroupValue = i!;
                      });

                  //    print(segmentedControlGroupValue);
                    }),*/
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'By $actionText, you agree to our terms and conditions.',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            );
          },
          headerBuilder: (context, constraints, shrinkOffset) {
            return Center(
              child: Image.asset('assets/asset/smartphone.png',
                  width: 100, height: 100),
            );
          },
          providers: [EmailAuthProvider()],
          actions: [
            AuthStateChangeAction<UserCreated>((context, state) async {
              _createUserDocument(state.credential.user!);
              //    DatabaseReference ref = FirebaseDatabase.instance
              //         .ref("users/${state.credential.user!.uid}");
              //      await ref.set({
              //       "attedanceInDays": 0,
              //     });
              if (kDebugMode) {
                print('New User Created');
              }
            }),
            AuthStateChangeAction<SignedIn>((context, state) {}),
          ],
        );
      },
    );
  }

  void _createUserDocument(User user) {
    FirebaseFirestore.instance.collection('attendifyUsers').doc(user.uid).set({
      'userId': user.uid,
      'userAlias': "User",
      'userName': "User",
      'userEmail': user.email,
      'userRole':
          "user", //segmentedControlGroupValue == 0 ? 'student' : 'admin',
      'userPhone': '',
      'userDepartment': '',
      'userGender': '',
      'userAge': '',
      'userProfileImage': ''
          'https://cdn-icons-png.flaticon.com/512/666/666201.png',
      'userAddress': '',
    });
  }
}*/
