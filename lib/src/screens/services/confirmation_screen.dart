import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy/theme.dart';


class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> bookingDetails;
  final String serviceSvg;

  const ConfirmationScreen({
    super.key,
    required this.bookingDetails,
    required this.serviceSvg,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: screenWidth * 0.40,
                height: screenWidth * 0.40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: SvgPicture.asset(
                  serviceSvg,
                  height: screenWidth * 0.35,
                  width: screenWidth * 0.35,
                  fit: BoxFit.contain,
                ).animate().fadeIn(duration: 400.ms),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              "Booking Confirmed!",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: screenWidth * 0.07,
                    fontFamily: 'Poppins',
                  ),
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "${bookingDetails['service']} - ${bookingDetails['package']}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: screenWidth * 0.05,
                    fontFamily: 'Poppins',
                  ),
            ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "For ${bookingDetails['pet']}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
            ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "On ${bookingDetails['date']} at ${bookingDetails['time']}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: petTheme.boneColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
            ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
            if (bookingDetails['notes'] != null && bookingDetails['notes'].isNotEmpty) ...[
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Notes: ${bookingDetails['notes']}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
              ).animate().fadeIn(duration: 400.ms, delay: 600.ms),
            ],
            SizedBox(height: screenHeight * 0.04),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst); // Return to HomeScreen
                },
                child: Text(
                  "Back to Home",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ).animate().scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.bounceOut,
                ),
          ],
        ),
      ),
    );
  }
}