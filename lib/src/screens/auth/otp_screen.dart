import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petbuddy/src/screens/home/home_screen.dart';
import 'package:petbuddy/theme.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  OTPScreen({required this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Access the custom theme extension
    final petAppTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  petAppTheme.backgroundCircle1,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Background Decorative Elements (Paw Prints and Toys)
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.1,
            child: Icon(
              Icons.pets,
              size: screenWidth * 0.08,
              color: petAppTheme.boneColor.withOpacity(0.5),
            ).animate().fadeIn(delay: 800.ms).moveY(
                  begin: -20,
                  end: 20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          Positioned(
            bottom: screenHeight * 0.1,
            right: screenWidth * 0.1,
            child: Icon(
              Icons.pets,
              size: screenWidth * 0.08,
              color: petAppTheme.boneColor.withOpacity(0.5),
            ).animate().fadeIn(delay: 1000.ms).moveY(
                  begin: 20,
                  end: -20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          Positioned(
            top: screenHeight * 0.15,
            right: screenWidth * 0.05,
            child: Icon(
              Icons.favorite,
              size: screenWidth * 0.06,
              color: petAppTheme.heartColor.withOpacity(0.7),
            ).animate().fadeIn(delay: 1200.ms).moveX(
                  begin: -20,
                  end: 20,
                  duration: 1500.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    // Back Button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: screenWidth * 0.08,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ).animate().fadeIn(duration: 800.ms),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PawPal OTP",
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: screenWidth * 0.08,
                              ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Icon(
                          Icons.pets,
                          size: screenWidth * 0.08,
                        ).animate().fadeIn(delay: 1000.ms).rotate(),
                      ],
                    )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: -0.5, end: 0, duration: 600.ms),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Enter the 4-digit code sent to ${widget.phoneNumber}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.045,
                          ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 1000.ms),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Edit Number",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: screenWidth * 0.045,
                              ),
                        ).animate().fadeIn(delay: 1200.ms),
                        SizedBox(width: screenWidth * 0.02),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Edit",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: screenWidth * 0.045,
                                ),
                          ),
                        ).animate().fadeIn(delay: 1200.ms),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    // OTP Input Fields
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: screenWidth * 0.04,
                      runSpacing: screenWidth * 0.04,
                      children: List.generate(4, (index) {
                        return Container(
                          width: screenWidth * 0.14,
                          height: screenWidth * 0.14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          child: TextField(
                            controller: _otpControllers[index],
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: screenWidth * 0.06,
                                ),
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    fontSize: screenWidth * 0.06,
                                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  ),
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ).animate().fadeIn(delay: 1600.ms + (index * 200).ms).scale(
                              begin: Offset(0.8, 0.8),
                              end: Offset(1.0, 1.0),
                              duration: 600.ms,
                              curve: Curves.bounceOut,
                            );
                      }),
                    ),
                    
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Resend Code?",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: screenWidth * 0.04,
                              ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        TextButton(
                          onPressed: () {
                            // Resend OTP logic here
                          },
                          child: Text(
                            "Resend",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: screenWidth * 0.04,
                                ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 2000.ms),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton(
                      onPressed: () {
                        // Verify OTP logic here
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  
                                ),
                              ),
                            );
                      },
                      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                            minimumSize: MaterialStateProperty.all(
                              Size(screenWidth * 0.9, screenHeight * 0.07),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.1),
                              ),
                            ),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Verify & Join!",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontSize: screenWidth * 0.045,
                                ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Icon(
                            Icons.pets,
                            size: screenWidth * 0.05,
                          ).animate().rotate(duration: 800.ms),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 2200.ms)
                        .scale(
                          begin: Offset(0.8, 0.8),
                          end: Offset(1.0, 1.0),
                          duration: 800.ms,
                          curve: Curves.bounceOut,
                        ),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}