import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practise_app/Authentication/forgotpassword.dart';
import 'package:practise_app/Authentication/login.dart';
import 'package:practise_app/Authentication/registration.dart';
import 'package:practise_app/pages/add_detail.dart';
import 'package:practise_app/pages/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAxcSMzog8WT8OCTophCzwTgKT4Bdk_4gM",
    appId: "1:973764054928:android:bc6d5b6b9841e68506ad15",
    messagingSenderId: "973764054928",
    projectId: "practise-app-6a1fd",
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Practise App',
      home:Home(),
    );
  }
}
