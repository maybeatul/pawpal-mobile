import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy/src/screens/services/booking_modal.dart';
import 'package:petbuddy/theme.dart';

class BookingScreen extends StatelessWidget {
  final String serviceTitle;
  final IconData serviceIcon;
  final String serviceSvg;

  const BookingScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceIcon,
    required this.serviceSvg,
  });

  // Sample packages for each service, marked as const
  final Map<String, List<Map<String, dynamic>>> servicePackages = const {
    'Grooming': [
      const {'name': 'Basic', 'description': 'Bath and Brush', 'charge': 25.0},
      const {'name': 'Deluxe', 'description': 'Bath, Brush, Nail Trim', 'charge': 40.0},
      const {'name': 'Premium', 'description': 'Full Grooming + Spa', 'charge': 60.0},
      const {'name': 'Luxury', 'description': 'Full Grooming + Spa + Massage', 'charge': 80.0},
    ],
    'Vet Checkup': [
      const {'name': 'Routine', 'description': 'Basic Health Check', 'charge': 30.0},
      const {'name': 'Comprehensive', 'description': 'Health Check + Vaccinations', 'charge': 50.0},
      const {'name': 'Advanced', 'description': 'Full Checkup + Lab Tests', 'charge': 70.0},
      const {'name': 'Emergency', 'description': 'Urgent Care', 'charge': 100.0},
    ],
    'Training': [
      const {'name': 'Beginner', 'description': 'Basic Commands', 'charge': 35.0},
      const {'name': 'Intermediate', 'description': 'Intermediate Skills', 'charge': 50.0},
      const {'name': 'Advanced', 'description': 'Advanced Skills', 'charge': 65.0},
      const {'name': 'Expert', 'description': 'Specialized Training', 'charge': 85.0},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;
    final packages = servicePackages[serviceTitle] ?? [];
    print("serviceTitle: $serviceTitle");
    print("Packages for $serviceTitle: $packages");

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Book $serviceTitle',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.06,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: Container(
                  width: screenWidth * 0.45,
                  height: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: SvgPicture.asset(
                    serviceSvg,
                    height: screenWidth * 0.4,
                    width: screenWidth * 0.4,
                    fit: BoxFit.contain,
                  ).animate().fadeIn(
                        duration: 400.ms,
                        delay: 200.ms,
                      ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Choose a package for $serviceTitle',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[600],
                      fontFamily: 'ComicNeue',
                    ),
                textAlign: TextAlign.left,
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 300.ms,
                  ),
              SizedBox(height: screenHeight * 0.04),
              // Packages List
              ...packages.isEmpty
                  ? [
                      const Center(
                        child: Text(
                          "No packages available for this service",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontFamily: 'ComicNeue',
                          ),
                        ),
                      ),
                    ]
                  : packages.map((package) {
                      print("Rendering package: ${package['name']}");
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: petTheme.boneColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            petTheme.backgroundCircle1,
                                            petTheme.backgroundCircle2,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        border: Border.all(
                                          color: petTheme.boneColor.withOpacity(0.3),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        serviceIcon,
                                        size: screenWidth * 0.06,
                                        color: petTheme.heartColor,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.04),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            package['name'],
                                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                                  fontSize: screenWidth * 0.045,
                                                  fontFamily: 'ComicNeue',
                                                  color: Theme.of(context).textTheme.headlineMedium!.color ?? Colors.black,
                                                ),
                                          ),
                                          SizedBox(height: screenHeight * 0.005),
                                          Text(
                                            package['description'],
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  fontSize: screenWidth * 0.035,
                                                  color: Colors.grey[600],
                                                  fontFamily: 'ComicNeue',
                                                ),
                                          ),
                                          SizedBox(height: screenHeight * 0.005),
                                          Text(
                                            "\$${package['charge'].toStringAsFixed(2)}",
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                  fontSize: screenWidth * 0.038,
                                                  color: petTheme.boneColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'ComicNeue',
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => BookingModal(
                                          serviceTitle: serviceTitle,
                                          package: package,
                                          serviceSvg: serviceSvg,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01,
                                        horizontal: screenWidth * 0.03,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColor.withOpacity(0.7),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        "Select Package",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'ComicNeue',
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animate().fadeIn(
                            duration: 400.ms,
                            delay: 400.ms,
                          );
                    }).toList(),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}