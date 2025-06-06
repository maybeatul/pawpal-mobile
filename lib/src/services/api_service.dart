import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petbuddy/app_constant.dart';
import 'package:petbuddy/src/helpers/localstorage_helper.dart';
import 'package:petbuddy/src/models/pet.dart';
import 'package:petbuddy/src/models/services_categories.dart';
import 'package:petbuddy/src/screens/auth/LoginScreen.dart';
import 'package:petbuddy/src/screens/auth/otp_screen.dart';
import 'package:petbuddy/src/screens/main_screen.dart';

class ApiService {
  final String _baseUrl = AppConstant.apiBaseUrl;

// Login Method

Future<void> sendOtp(String mobileNumber, BuildContext context) async {
  final url = Uri.parse('$_baseUrl/auth/send_otp');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'mobile_number': mobileNumber}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      showSnack(context, data['message'] ?? 'OTP sent successfully');
      // Naviage to OTP verification screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen( phoneNumber:mobileNumber),
        ),   
      );

      // return {'success': true};
    } else {
      final body = jsonDecode(response.body);
      showSnack(context, body['message'] ?? 'Failed to send OTP', isError: true);
      // return {
      //   'success': false,
      //   'message': body['message'] ?? 'OTP sending failed. Please try again.',
      // };
    }
  } catch (e) {
    showSnack(context, 'Something went wrong: ${e.toString()}', isError: true);
    // return {'success': false, 'message': 'Unexpected error'};
  }
}


  Future<void> verifyOtp(String mobileNumber, String otp, BuildContext context) async {
    final url = Uri.parse('$_baseUrl/auth/verify_otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile_number': mobileNumber, 'otp_code': otp}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showSnack(context, data['message'] ?? 'OTP verified successfully');
        print('Access Token: ${data['access_token']}');
        // Store access token in local storage
        await LocalstorageHelper.setString('access_token', data['access_token']);
        // Navigate to main screen after successful login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // removes all previous routes
        );
        //  Snackbar to show success message
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Login successful!'),
        //     backgroundColor: Colors.green,
        //     duration: const Duration(seconds: 2),
        //   ),
        // );
        // // return {'success': true};
      } else {
        final body = jsonDecode(response.body);
        showSnack(context, body['message'] ?? 'Failed to verify OTP', isError: true);
        // return {
        //   'success': false,
        //   'message': body['message'] ?? 'OTP verification failed. Please try again.',
        // };
      }
    }  catch (e) {
      showSnack(context, 'Something went wrong: ${e.toString()}', isError: true);
      // return {'success': false, 'message': 'Unexpected error'};
    }
  }

void logout(BuildContext context) async {
  // Clear access token from local storage
  await LocalstorageHelper.clear();
  // Navigate to login screen
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) =>  LoginScreen()),
    (Route<dynamic> route) => false, // removes all previous routes
  );
}




// Fetch all services 
Future<List<ServicesCategories>> fetchServiceCategories() async {
  final url = Uri.parse('$_baseUrl/service_categories');

  try {
    // Get access token from local storage
    final accessToken = LocalstorageHelper.getString('access_token');

    // Make GET request with Authorization header
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Parse list of service categories
      return (data['service_categories'] as List)
              .map((item) => ServicesCategories.fromJson(item))
              .toList();
    } else {
      throw Exception('Failed to load services');
    }
  } catch (e) {
    print('Error fetching services: $e');
    return [];
  }
}


Future<List<Pet>> fetchPetsByUserId(String userId) async {
  final url = Uri.parse('$_baseUrl/users/$userId/pets');
  try {
    // Get access token from local storage
    final accessToken = await LocalstorageHelper.getString('access_token');

    // Check if access token exists
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Access token not found or invalid');
    }

    // Make GET request with Authorization header
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    // Handle response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Validate the response structure
      if (data is Map<String, dynamic> && data['pets'] is List) {
        // Log the raw JSON response
        print('Pets fetched successfully: ${data['pets']}');
        print('Pets Count: ${data['pets'].length}');

        // Convert the JSON list to a List<Pet>
        final List<Pet> pets = (data['pets'] as List)
            .map((petJson) => Pet.fromJson(petJson! as Map<String, dynamic>))
            .toList();

        // Log each pet individually
        // for (var pet in pets) {
        //   print('Pet: ${pet.name}, Type: ${pet.petType}, Age: ${pet.age}');
        // }
        print('Total Pets Fetched: ${pets.length}');

        return pets;
      } else {
        throw Exception('Invalid response structure: "pets" key not found or not a list');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or expired token');
    } else {
      throw Exception('Failed to load pets: ${response.statusCode} - ${response.reasonPhrase}');
    }
  } catch (e) {
    // Log the error (use a proper logging mechanism in production)
    print('Error fetching pets: $e');
    rethrow; // Rethrow to let the caller handle the error
  }
}
  void showSnack(BuildContext context, String message, {bool isError = false}) {
  final color = isError ? Colors.red : Colors.green;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ),
  );
}

}


