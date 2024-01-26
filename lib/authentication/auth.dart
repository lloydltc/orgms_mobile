import 'package:flutter/material.dart';
import 'package:organisation_management/screens/registration.dart';

import '../screens/login.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});
  @override
  _AuthState createState() => _AuthState();
}
class _AuthState extends State<Auth> {
  bool showRegister= true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("kk"),
            elevation: 16.0,
            actions: [
              IconButton(
                  icon: Icon(Icons.swap_horiz),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      showRegister = !showRegister;
                    });
                  })
            ],
          ),
          body: Container(child: showRegister ? Registration() : Login())),
    );
    // ternary operator

  }
}