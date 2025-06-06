import 'package:flutter/material.dart';
import 'package:petbuddy/src/helpers/localstorage_helper.dart';
import 'package:petbuddy/src/screens/auth/GetStartedScreen.dart';
import 'package:petbuddy/src/screens/auth/LoginScreen.dart';
import 'package:petbuddy/src/screens/main_screen.dart';
import 'package:petbuddy/theme.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); // ✅ REQUIRED
  await LocalstorageHelper.init(); // Initialize local storage helper
  // Check for access token
  final accessToken = LocalstorageHelper.getString('access_token');
//  runApp(MyApp(isLoggedIn: accessToken != null? true : false));
  final bool isLoggedIn;
  if (accessToken != null && accessToken.isNotEmpty) {
    isLoggedIn = true; // User is logged in
  } else {
    isLoggedIn = false; // User is not logged in
  }
  runApp(MyApp(isLoggedIn:isLoggedIn)); // For testing without login
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PetAppTheme.lightTheme,
      home: isLoggedIn ? MainScreen() : LoginScreen(),
    );
  }
}
