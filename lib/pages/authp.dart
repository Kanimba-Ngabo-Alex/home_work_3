import 'package:midsem/pages/navbar.dart';
import 'package:midsem/pages/login_or_register_oages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return HomePage();

              //user is not logged in
            } else {
              return LoginOrRegisterPage();
            }
          }),
    );
  }
}
