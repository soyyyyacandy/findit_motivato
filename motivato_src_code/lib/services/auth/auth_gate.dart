import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivato/pages/home_page.dart'; // Import the HomePage widget
import 'package:motivato/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // If user is authenticated, redirect to the home page
            return HomePage(); // Return the HomePage widget
          } else {
            // If user is not authenticated, show the login or register page
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}


