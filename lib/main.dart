import 'package:blood_donor/model/firebase_options.dart';
import 'package:blood_donor/screens/add_donor.dart';
import 'package:blood_donor/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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