// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:petbuddy/theme.dart';
// import 'otp_screen.dart';

// class LoginScreen extends StatelessWidget {
//   final TextEditingController _phoneController = TextEditingController();

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final petAppTheme = theme.extension<PetAppThemeExtension>()!;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: Stack(
//         children: [
//           // Background Decorative Elements
//           Positioned(
//             top: -50,
//             left: -50,
//             child: Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: petAppTheme.backgroundCircle1,
//               ),
//             )
//                 .animate()
//                 .fadeIn(duration: 1200.ms)
//                 .scale(
//                   begin: Offset(0.5, 0.5),
//                   end: Offset(1.0, 1.0),
//                   duration: 1000.ms,
//                   curve: Curves.easeInOut,
//                 ),
//           ),
//           Positioned(
//             bottom: -50,
//             right: -50,
//             child: Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: petAppTheme.backgroundCircle2,
//               ),
//             )
//                 .animate()
//                 .fadeIn(duration: 1200.ms)
//                 .scale(
//                   begin: Offset(0.5, 0.5),
//                   end: Offset(1.0, 1.0),
//                   duration: 1000.ms,
//                   curve: Curves.easeInOut,
//                 ),
//           ),
//           // Main Content
//           Column(
//             children: [
//               // Top Section with Title and Illustration
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Animated Title with Paw Print
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "PawPal",
//                           style: theme.textTheme.headlineLarge,
//                         )
//                             .animate()
//                             .fadeIn(duration: 1000.ms)
//                             .slideY(begin: -0.5, end: 0, duration: 800.ms)
//                             .then()
//                             .shake(duration: 600.ms, hz: 3),
//                         SizedBox(width: 10),
//                         Icon(
//                           Icons.pets,
//                           color: theme.primaryColor,
//                           size: 30,
//                         ).animate().fadeIn(delay: 1200.ms).rotate(),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     // Animated Pet Illustration with Decorative Elements
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Background Circle
//                         Container(
//                           width: 220,
//                           height: 220,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 petAppTheme.backgroundCircle1.withOpacity(1.0),
//                                 petAppTheme.backgroundCircle2.withOpacity(1.0),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                           ),
//                         )
//                             .animate()
//                             .scale(
//                               begin: Offset(0.8, 0.8),
//                               end: Offset(1.0, 1.0),
//                               duration: 800.ms,
//                               curve: Curves.bounceOut,
//                             ),
//                         // Pet Placeholder (Replace with Image.asset)
//                         Container(
//                           width: 180,
//                           height: 180,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                           child: Icon(
//                             Icons.pets,
//                             size: 100,
//                             color: theme.primaryColor,
//                           ),
//                         )
//                             .animate()
//                             .scale(
//                               begin: Offset(0.5, 0.5),
//                               end: Offset(1.0, 1.0),
//                               duration: 1000.ms,
//                               curve: Curves.bounceOut,
//                             )
//                             .shake(duration: 600.ms, hz: 2),
//                         // Decorative Bone
//                         Positioned(
//                           top: 20,
//                           right: 20,
//                           child: Icon(
//                             Icons.pets,
//                             size: 40,
//                             color: petAppTheme.boneColor,
//                           ).animate().fadeIn(delay: 1200.ms).rotate(),
//                         ),
//                         // Decorative Heart
//                         Positioned(
//                           bottom: 20,
//                           left: 20,
//                           child: Icon(
//                             Icons.favorite,
//                             size: 40,
//                             color: petAppTheme.heartColor,
//                           ).animate().fadeIn(delay: 1400.ms).rotate(),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Bottom Section with Input and Button
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.all(30),
//                   decoration: BoxDecoration(
//                     color: theme.cardTheme.color,
//                     borderRadius: (theme.cardTheme.shape as RoundedRectangleBorder?)?.borderRadius,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         spreadRadius: 5,
//                         blurRadius: 10,
//                         offset: Offset(0, -5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Welcome, Pet Lover!",
//                         style: theme.textTheme.headlineMedium,
//                       )
//                           .animate()
//                           .fadeIn(duration: 800.ms)
//                           .slideX(begin: -0.5, end: 0, duration: 600.ms),
//                       SizedBox(height: 15),
//                       Text(
//                         "Enter your mobile number to join the pack!",
//                         style: theme.textTheme.bodyMedium,
//                       ).animate().fadeIn(delay: 1000.ms),
//                       SizedBox(height: 30),
//                      TextField(
//   controller: _phoneController,
//   keyboardType: TextInputType.phone,
//   decoration: InputDecoration(
//     prefixIcon: Icon(
//       Icons.phone,
//       size: 20,
//     ),
//     hintText: 'Mobile number',
//     filled: true,
//     fillColor: Theme.of(context).scaffoldBackgroundColor,
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30),
//       borderSide: BorderSide.none,
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30),
//       borderSide: BorderSide(
//         color: Colors.transparent,
//         width: 2,
//       ),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30),
//       borderSide: BorderSide(
//         color: Theme.of(context).primaryColor,
//         width: 2,
//       ),
//     ),
//   ),
// )
//     .animate()
//     .fadeIn(delay: 1200.ms)
//     .slideX(begin: 0.5, end: 0, duration: 600.ms),
//                       SizedBox(height: 30),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_phoneController.text.isNotEmpty) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => OTPScreen(
//                                   phoneNumber: _phoneController.text,
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         child: Text("Get OTP"),
//                       )
//                           .animate()
//                           .fadeIn(delay: 1400.ms)
//                           .scale(
//                             begin: Offset(0.8, 0.8),
//                             end: Offset(1.0, 1.0),
//                             duration: 800.ms,
//                             curve: Curves.bounceOut,
//                           ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petbuddy/src/services/api_service.dart';
import 'package:petbuddy/theme.dart';
import 'otp_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final petAppTheme = theme.extension<PetAppThemeExtension>()!;

    // Function to dismiss keyboard
    void dismissKeyboard() {
      FocusScope.of(context).unfocus();
    }

    return GestureDetector(
      onTap: dismissKeyboard, // Dismiss keyboard when tapping outside
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              // Background Decorative Elements
              Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: petAppTheme.backgroundCircle1,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 1200.ms)
                    .scale(
                      begin: Offset(0.5, 0.5),
                      end: Offset(1.0, 1.0),
                      duration: 1000.ms,
                      curve: Curves.easeInOut,
                    ),
              ),
              Positioned(
                bottom: -50,
                right: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: petAppTheme.backgroundCircle2,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 1200.ms)
                    .scale(
                      begin: Offset(0.5, 0.5),
                      end: Offset(1.0, 1.0),
                      duration: 1000.ms,
                      curve: Curves.easeInOut,
                    ),
              ),
              // Main Content
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                ),
                child: Column(
                  children: [
                    // Top Section with Title and Illustration
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40), // Add some top padding
                        // Animated Title with Paw Print
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PawPal",
                              style: theme.textTheme.headlineLarge,
                            )
                                .animate()
                                .fadeIn(duration: 1000.ms)
                                .slideY(
                                    begin: -0.5, end: 0, duration: 800.ms)
                                .then()
                                .shake(duration: 600.ms, hz: 3),
                            SizedBox(width: 10),
                            Icon(
                              Icons.pets,
                              color: theme.primaryColor,
                              size: 30,
                            ).animate().fadeIn(delay: 1200.ms).rotate(),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Animated Pet Illustration with Decorative Elements
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background Circle
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    petAppTheme.backgroundCircle1
                                        .withOpacity(1.0),
                                    petAppTheme.backgroundCircle2
                                        .withOpacity(1.0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            )
                                .animate()
                                .scale(
                                  begin: Offset(0.8, 0.8),
                                  end: Offset(1.0, 1.0),
                                  duration: 800.ms,
                                  curve: Curves.bounceOut,
                                ),
                            // Pet Placeholder
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              child: Icon(
                                Icons.pets,
                                size: 100,
                                color: theme.primaryColor,
                              ),
                            )
                                .animate()
                                .scale(
                                  begin: Offset(0.5, 0.5),
                                  end: Offset(1.0, 1.0),
                                  duration: 1000.ms,
                                  curve: Curves.bounceOut,
                                )
                                .shake(duration: 600.ms, hz: 2),
                            // Decorative Bone
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Icon(
                                Icons.pets,
                                size: 40,
                                color: petAppTheme.boneColor,
                              ).animate().fadeIn(delay: 1200.ms).rotate(),
                            ),
                            // Decorative Heart
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Icon(
                                Icons.favorite,
                                size: 40,
                                color: petAppTheme.heartColor,
                              ).animate().fadeIn(delay: 1400.ms).rotate(),
                            ),
                          ],
                        ),
                        SizedBox(height: 40), // Add spacing before bottom section
                      ],
                    ),
                    // Bottom Section with Input and Button
                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius:
                            (theme.cardTheme.shape as RoundedRectangleBorder?)
                                ?.borderRadius,
                       boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 2, // Reduced to minimize side spread
    blurRadius: 5, // Reduced for sharper shadow
    offset: Offset(0, -5), // Larger negative offset to shift shadow upward
  ),
],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Welcome, Pet Lover!",
                            style: theme.textTheme.headlineMedium,
                          )
                              .animate()
                              .fadeIn(duration: 800.ms)
                              .slideX(
                                  begin: -0.5, end: 0, duration: 600.ms),
                          SizedBox(height: 15),
                          Text(
                            "Enter your mobile number to join the pack!",
                            style: theme.textTheme.bodyMedium,
                          ).animate().fadeIn(delay: 1000.ms),
                          SizedBox(height: 30),
                         TextField(
  controller: _phoneController,
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(
    prefixIcon: Icon(
      Icons.phone,
      size: 20,
    ),
    hintText: 'Mobile number',
    filled: true,
    fillColor: theme.scaffoldBackgroundColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none, // Default border (no visible border)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: theme.dividerColor, // Visible border when not focused
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: theme.primaryColor, // Border when focused
        width: 2,
      ),
    ),
  ),
  onSubmitted: (value) {
    dismissKeyboard();
  },
)
    .animate()
    .fadeIn(delay: 1200.ms)
    .slideX(begin: 0.5, end: 0, duration: 600.ms),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              final phone = _phoneController.text.trim();
                              if (phone.isNotEmpty && phone.length >= 10) {
                                dismissKeyboard();
                                ApiService().sendOtp(phone, context);
                                  
                              }
                                
                            },
                            child: Text("Get OTP"),
                          )
                              .animate()
                              .fadeIn(delay: 1400.ms)
                              .scale(
                                begin: Offset(0.8, 0.8),
                                end: Offset(1.0, 1.0),
                                duration: 800.ms,
                                curve: Curves.bounceOut,
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30), // Extra padding at the bottom
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}