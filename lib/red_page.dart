import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  const RedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
            "This Is Red Page",
            style: TextStyle(fontSize: 35, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 157, 14, 4),
    );
  }
}
