// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motivato/firebase_options.dart';
import 'package:motivato/pages/loading_page.dart';
import 'package:motivato/theme/light_mode.dart';
import 'package:motivato/components/streak.dart';
import 'package:motivato/pages/home_page.dart';
//import 'pages/login_page.dart';
//import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: SplashScreen(),
      theme: lightMode,
    );
  }
}
