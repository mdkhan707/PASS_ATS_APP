// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pass_ats/nav_bar.dart';

// class GoogleSignInController extends GetxController {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   var isLoading = false.obs;
//   var isLoggedIn = false.obs;
//   var userData = Rx<Map<String, dynamic>>({});

//   final String baseUrl =
//       'http://10.0.2.2:5000/api/auth'; // Change this to your actual API URL

//   @override
//   void onInit() {
//     super.onInit();
//     checkLoginStatus();
//   }

//   // Check if user is already logged in
//   Future<void> checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('jwt_token');
//     final user = prefs.getString('user_data');

//     if (token != null && user != null) {
//       isLoggedIn.value = true;
//       userData.value = jsonDecode(user);

//       // Validate token (optional)
//       // await validateToken(token);
//     }
//   }

//   // Sign in with Google
//   Future<void> signInWithGoogle() async {
//     try {
//       isLoading.value = true;

//       // Start Google Sign In flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         // User canceled the sign-in
//         isLoading.value = false;
//         return;
//       }

//       // Get authentication details
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       final String? idToken = googleAuth.idToken;

//       if (idToken == null) {
//         Get.snackbar("Error", "Failed to get Google ID token",
//             backgroundColor: Colors.red, colorText: Colors.white);
//         isLoading.value = false;
//         return;
//       }

//       // Send token to backend
//       await _authenticateWithBackend(idToken);
//     } catch (e) {
//       Get.snackbar("Error", "Google Sign-In failed: ${e.toString()}",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       print("Google Sign-In Error: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Send ID token to backend and process response
//   Future<void> _authenticateWithBackend(String idToken) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/google'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'token': idToken,
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Parse response
//         final Map<String, dynamic> data = jsonDecode(response.body);

//         // Extract JWT token and user data
//         final String jwtToken = data['token'];
//         final Map<String, dynamic> user = data['user'];

//         // Save to shared preferences
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('jwt_token', jwtToken);
//         await prefs.setString('user_data', jsonEncode(user));

//         // Update state
//         isLoggedIn.value = true;
//         userData.value = user;

//         // Show success message
//         Get.snackbar("Success", "Google login successful",
//             backgroundColor: Colors.green, colorText: Colors.white);

//         // Navigate to home screen
//         Get.offAll(() => Custom_NavigationBar());
//       } else {
//         // Handle error
//         final Map<String, dynamic> errorData = jsonDecode(response.body);
//         final String errorMessage =
//             errorData['message'] ?? 'Authentication failed';

//         Get.snackbar("Error", errorMessage,
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar(
//           "Error", "Failed to communicate with server: ${e.toString()}",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       print("Backend Authentication Error: $e");
//     }
//   }

//   // Sign out
//   Future<void> signOut() async {
//     try {
//       isLoading.value = true;

//       // Sign out from Google
//       await _googleSignIn.signOut();

//       // Clear local storage
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove('jwt_token');
//       await prefs.remove('user_data');

//       // Update state
//       isLoggedIn.value = false;
//       userData.value = {};

//       Get.snackbar("Success", "Signed out successfully",
//           backgroundColor: Colors.blue, colorText: Colors.white);

//       // Navigate to login screen (if you have one)
//       // Get.offAll(() => LoginScreen());
//     } catch (e) {
//       Get.snackbar("Error", "Sign out failed: ${e.toString()}",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Get user token for API requests
//   Future<String?> getUserToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('jwt_token');
//   }

//   // Example method to validate token (optional)
//   Future<bool> validateToken(String token) async {
//     // Implement token validation with your backend if needed
//     return true;
//   }
// }
