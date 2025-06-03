import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/auth/GetStartedScreen.dart';
import 'package:petbuddy/src/screens/auth/LoginScreen.dart';
import 'package:petbuddy/src/screens/main_screen.dart';
import 'package:petbuddy/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PetAppTheme.lightTheme, // Apply the pet app theme
      // home: MainScreen(),
      // home: const GetStartedScreen(),
      home:  LoginScreen(), // Set the initial screen to LoginScreen
    );
  }
}
