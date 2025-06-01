import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petbuddy/src/screens/auth/LoginScreen.dart';
import 'package:confetti/confetti.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Controller for confetti animation
    final confettiController = ConfettiController(duration: const Duration(seconds: 3));

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor, // #E6F0FA
                  const Color(0xFFFFF3E0), // Light peach
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                // Animated paw print trail
                Positioned(
                  top: screenHeight * 0.15,
                  left: 0,
                  child: Row(
                    children: List.generate(4, (index) => Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.15),
                      child: Icon(
                        Icons.pets,
                        size: screenWidth * 0.05,
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ).animate().fadeIn(delay: (800 + index * 200).ms).moveX(
                            begin: -20,
                            end: screenWidth,
                            duration: 3000.ms,
                            curve: Curves.easeInOut,
                          ),
                    )),
                  ),
                ),
                // Animated pet silhouette (dog)
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.1,
                  child: Icon(
                    Icons.pets,
                    size: screenWidth * 0.1,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ).animate().move(
                        begin: const Offset(0, 0),
                        end: const Offset(200, 50),
                        duration: 5000.ms,
                        curve: Curves.easeInOut,
                        // repeat: RepeatMode.reverse,
                      ).shake(
                        duration: 800.ms,
                        hz: 2,
                        rotation: 0.05,
                      ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo with layered pet elements
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: screenWidth * 0.35,
                              height: screenWidth * 0.35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor, // #EF6C00
                                    const Color(0xFFFF80AB), // Soft pink
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.pets,
                              size: screenWidth * 0.18,
                              color: Colors.white,
                            ),
                            Positioned(
                              top: screenWidth * 0.05,
                              right: screenWidth * 0.05,
                              child: Icon(
                                Icons.favorite,
                                size: screenWidth * 0.06,
                                color: Colors.white.withOpacity(0.8),
                              ).animate().moveY(
                                    begin: 0,
                                    end: -5,
                                    duration: 500.ms,
                                    curve: Curves.easeInOut,
                                    // repeat: RepeatMode.reverse,
                                  ),
                            ),
                          ],
                        ).animate().scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1.0, 1.0),
                              duration: 800.ms,
                              curve: Curves.bounceOut,
                            ).shake(
                              duration: 600.ms,
                              hz: 2,
                              rotation: 0.05,
                            ),
                        SizedBox(height: screenHeight * 0.03),
                        // App Name
                        Text(
                          "PawPal",
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: screenWidth * 0.09,
                                color: Theme.of(context).primaryColor,
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                        ).animate().fadeIn(delay: 600.ms).shake(
                              duration: 800.ms,
                              hz: 1,
                              rotation: 0.02,
                            ),
                        SizedBox(height: screenHeight * 0.05),
                        // Card with Title, Description, and Button
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Theme.of(context).primaryColor.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Let’s Find Your Pet’s Best Friend!",
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontSize: screenWidth * 0.06,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ).animate().fadeIn(delay: 800.ms).slideY(
                                    begin: 0.3,
                                    end: 0,
                                    duration: 600.ms,
                                  ),
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                "Discover top-notch pet services with love and care",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.grey[700],
                                    ),
                                textAlign: TextAlign.center,
                              ).animate().fadeIn(delay: 1000.ms),
                              SizedBox(height: screenHeight * 0.03),
                              // Animated Paw Indicator (instead of dots)
                              Icon(
                                Icons.pets,
                                size: screenWidth * 0.06,
                                color: Theme.of(context).primaryColor,
                              ).animate().scale(
                                    begin: const Offset(1.0, 1.0),
                                    end: const Offset(1.2, 1.2),
                                    duration: 1000.ms,
                                    curve: Curves.easeInOut,
                                    // repeat: RepeatMode.reverse,
                                  ),
                              SizedBox(height: screenHeight * 0.03),
                              // Get Started Button
                              ElevatedButton(
                                onPressed: () {
                                  confettiController.play(); // Trigger confetti
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  LoginScreen()),
                                    );
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Container(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.07,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor, // #EF6C00
                                        const Color(0xFFFF80AB), // Soft pink
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Start the Fun!",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.045,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Icon(
                                        Icons.pets,
                                        color: Colors.white,
                                        size: screenWidth * 0.06,
                                      ),
                                    ],
                                  ),
                                ),
                              ).animate().fadeIn(delay: 1400.ms).scale(
                                    begin: const Offset(0.9, 0.9),
                                    end: const Offset(1.0, 1.0),
                                    duration: 600.ms,
                                    curve: Curves.bounceOut,
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Confetti Widget
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Color(0xFFEF6C00), // Orange
              Color(0xFFFF80AB), // Pink
              Color(0xFFFFE082), // Yellow
              Colors.white,
            ],
            numberOfParticles: 50,
            gravity: 0.3,
            emissionFrequency: 0.02,
          ),
        ),
      ],
    );
  }
}