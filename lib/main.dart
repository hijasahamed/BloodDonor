import 'package:blood_donor/screens/add_donor.dart';
import 'package:blood_donor/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: 'AIzaSyAJCwZ6tiJN3XyLBmFO7b_rC8AWjiNPwxQ', 
      appId: '1:1041614196840:android:5a0719c08c8d14bea8abdd', 
      messagingSenderId: '1041614196840', 
      projectId: 'blood-donor-bbd51'
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donors',
      routes: {
        '1': (context) => const Homescreen(),
        '2': (context) => const Addblooduser(),
      },
      initialRoute: '1', 
    );
  }
}
