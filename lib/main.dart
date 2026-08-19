import 'package:flutter/material.dart';

import 'welcome_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const ReReadApp());
}

class ReReadApp extends StatelessWidget {
  const ReReadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'reread',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WelcomeScreen(),
    );
  }
}
