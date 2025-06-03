// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:petbuddy/src/screens/services/booking_modal.dart';
// import 'package:petbuddy/theme.dart';

// class BookingScreen extends StatelessWidget {
//   final String serviceTitle;
//   final IconData serviceIcon;
//   final String serviceSvg;

//   const BookingScreen({
//     super.key,
//     required this.serviceTitle,
//     required this.serviceIcon,
//     required this.serviceSvg,
//   });

//   // Sample packages for each service, marked as const
//   final Map<String, List<Map<String, dynamic>>> servicePackages = const {
//     'Grooming': [
//       const {'name': 'Basic', 'description': 'Bath and Brush', 'charge': 25.0},
//       const {'name': 'Deluxe', 'description': 'Bath, Brush, Nail Trim', 'charge': 40.0},
//       const {'name': 'Premium', 'description': 'Full Grooming + Spa', 'charge': 60.0},
//       const {'name': 'Luxury', 'description': 'Full Grooming + Spa + Massage', 'charge': 80.0},
//     ],
//     'Vet Checkup': [
//       const {'name': 'Routine', 'description': 'Basic Health Check', 'charge': 30.0},
//       const {'name': 'Comprehensive', 'description': 'Health Check + Vaccinations', 'charge': 50.0},
//       const {'name': 'Advanced', 'description': 'Full Checkup + Lab Tests', 'charge': 70.0},
//       const {'name': 'Emergency', 'description': 'Urgent Care', 'charge': 100.0},
//     ],
//     'Training': [
//       const {'name': 'Beginner', 'description': 'Basic Commands', 'charge': 35.0},
//       const {'name': 'Intermediate', 'description': 'Intermediate Skills', 'charge': 50.0},
//       const {'name': 'Advanced', 'description': 'Advanced Skills', 'charge': 65.0},
//       const {'name': 'Expert', 'description': 'Specialized Training', 'charge': 85.0},
//     ],
//   };

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;
//     final packages = servicePackages[serviceTitle] ?? [];
//     print("serviceTitle: $serviceTitle");
//     print("Packages for $serviceTitle: $packages");

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Custom Header
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.06,
//                 vertical: screenHeight * 0.02,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: Theme.of(context).primaryColor,
//                       size: screenWidth * 0.06,
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   Expanded(
//                     child: Text(
//                       'Book $serviceTitle',
//                       style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                             fontSize: screenWidth * 0.06,
//                             color: Theme.of(context).primaryColor,
//                             fontFamily: 'ComicNeue',
//                             fontWeight: FontWeight.bold,
//                           ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.06), // Spacer for symmetry
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: screenWidth * 0.25,
//                     height: screenWidth * 0.25,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: petTheme.heartColor.withOpacity(0.5),
//                         width: 2,
//                       ),
//                     ),
//                     child: SvgPicture.asset(
//                       serviceSvg,
//                       height: screenWidth * 0.2,
//                       width: screenWidth * 0.2,
//                       fit: BoxFit.contain,
//                     ).animate().fadeIn(
//                           duration: 600.ms,
//                           delay: 200.ms,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Text(
//               'Select a Package for Your Pet! 🐾',
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: screenWidth * 0.04,
//                     color: Colors.grey[600],
//                     fontFamily: 'ComicNeue',
//                   ),
//               textAlign: TextAlign.center,
//             ).animate().fadeIn(
//                   duration: 400.ms,
//                   delay: 400.ms,
//                 ),
//             SizedBox(height: screenHeight * 0.02),
//             // Package Cards
//             Expanded(
//   child: packages.isEmpty
//       ? const Center(
//           child: Text(
//             "No packages available for this service",
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.red,
//               fontFamily: 'ComicNeue',
//             ),
//           ),
//         )
//       : ListView.builder(
//           padding: EdgeInsets.symmetric(
//             vertical: screenHeight * 0.02,
//             horizontal: screenWidth * 0.06,
//           ),
//           itemCount: packages.length,
//           itemBuilder: (context, index) {
//             final package = packages[index];
//             final isPopular = package['name'] == 'Deluxe' || package['name'] == 'Premium'; // Example condition for "Popular" badge
//             print("Rendering package: ${package['name']}");
//             return Padding(
//               padding: EdgeInsets.only(bottom: screenHeight * 0.02),
//               child: GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     backgroundColor: Colors.transparent,
//                     builder: (context) => BookingModal(
//                       serviceTitle: serviceTitle,
//                       package: package,
//                       serviceSvg: serviceSvg,
//                     ),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white, // White background
//                     borderRadius: BorderRadius.circular(15), // Rounded corners
//                     boxShadow: [
//                       BoxShadow(
//                         color: petTheme.heartColor.withOpacity(0.2), // Use theme for shadow
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(screenWidth * 0.04),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Service Icon
//                                 Container(
//                                   width: screenWidth * 0.15,
//                                   height: screenWidth * 0.15,
//                                   child: SvgPicture.asset(
//                                     serviceSvg,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.04),
//                                 // Package Details
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       // Package Name
//                                       Text(
//                                         package['name'],
//                                         style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                                               fontSize: screenWidth * 0.05,
//                                               fontFamily: 'ComicNeue',
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                             ),
//                                       ),
//                                       SizedBox(height: screenHeight * 0.005),
//                                       // Pricing with Strikethrough
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "SUBSCRIBE @\$${package['charge'].toStringAsFixed(2)}",
//                                             style: TextStyle(
//                                               fontSize: screenWidth * 0.04,
//                                               color: petTheme.heartColor, // Use theme color
//                                               fontFamily: 'ComicNeue',
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(width: screenWidth * 0.02),
//                                           Text(
//                                             "\$${(package['charge'] + 10).toStringAsFixed(2)}", // Example strikethrough price
//                                             style: TextStyle(
//                                               fontSize: screenWidth * 0.035,
//                                               color: Colors.grey,
//                                               fontFamily: 'ComicNeue',
//                                               decoration: TextDecoration.lineThrough,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: screenHeight * 0.01),
//                                       // Service List with Checkmarks
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: (package['description'] as String)
//                                             .split(', ')
//                                             .map((service) => Padding(
//                                                   padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(
//                                                         Icons.check_circle,
//                                                         size: screenWidth * 0.04,
//                                                         color: Colors.grey[600],
//                                                       ),
//                                                       SizedBox(width: screenWidth * 0.02),
//                                                       Text(
//                                                         service,
//                                                         style: TextStyle(
//                                                           fontSize: screenWidth * 0.035,
//                                                           color: Colors.grey[600],
//                                                           fontFamily: 'ComicNeue',
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ))
//                                             .toList(),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             // Select Button (Moved to bottom-right)
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: screenHeight * 0.02),
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: screenWidth * 0.04,
//                                     vertical: screenHeight * 0.015,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(
//                                     "Select package",
//                                     style: TextStyle(
//                                       fontSize: screenWidth * 0.035,
//                                       color: Colors.white,
//                                       fontFamily: 'ComicNeue',
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ).animate().slideX(
//                     begin: -0.5,
//                     end: 0.0,
//                     duration: 600.ms,
//                     delay: 200.ms + (index * 100).ms,
//                     curve: Curves.easeOutCubic,
//                   ).fadeIn(
//                     duration: 600.ms,
//                     delay: 200.ms + (index * 100).ms,
//                   ),
//             );
//           },
//         ),
// ),
//           ],
//         ),
//       ),
//     );
//   }
// }


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
      {'name': 'Basic', 'description': 'Bath and Brush', 'charge': 25.0},
      {'name': 'Deluxe', 'description': 'Bath, Brush, Nail Trim', 'charge': 40.0},
      {'name': 'Premium', 'description': 'Full Grooming + Spa', 'charge': 60.0},
      {'name': 'Luxury', 'description': 'Full Grooming + Spa + Massage', 'charge': 80.0},
    ],
    'Vet Checkup': [
      {'name': 'Routine', 'description': 'Basic Health Check', 'charge': 30.0},
      {'name': 'Comprehensive', 'description': 'Health Check + Vaccinations', 'charge': 50.0},
      {'name': 'Advanced', 'description': 'Full Checkup + Lab Tests', 'charge': 70.0},
      {'name': 'Emergency', 'description': 'Urgent Care', 'charge': 100.0},
    ],
    'Training': [
      {'name': 'Beginner', 'description': 'Basic Commands', 'charge': 35.0},
      {'name': 'Intermediate', 'description': 'Intermediate Skills', 'charge': 50.0},
      {'name': 'Advanced', 'description': 'Advanced Skills', 'charge': 65.0},
      {'name': 'Expert', 'description': 'Specialized Training', 'charge': 85.0},
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
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                      size: screenWidth * 0.06,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      'Book $serviceTitle',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontSize: screenWidth * 0.06,
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'ComicNeue',
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.06), // Spacer for symmetry
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: petTheme.heartColor.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: SvgPicture.asset(
                      serviceSvg,
                      height: screenWidth * 0.2,
                      width: screenWidth * 0.2,
                      fit: BoxFit.contain,
                    ).animate().fadeIn(
                          duration: 600.ms,
                          delay: 200.ms,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Select a Package for Your Pet! 🐾',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey[600],
                    fontFamily: 'ComicNeue',
                  ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(
                  duration: 400.ms,
                  delay: 400.ms,
                ),
            SizedBox(height: screenHeight * 0.02),
            // Package Cards
            Expanded(
              child: packages.isEmpty
                  ? const Center(
                      child: Text(
                        "No packages available for this service",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontFamily: 'ComicNeue',
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.06,
                      ),
                      itemCount: packages.length,
                      itemBuilder: (context, index) {
                        final package = packages[index];
                        print("Rendering package: ${package['name']}");
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
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
                              decoration: BoxDecoration(
                                color: Colors.white, // White background
                                borderRadius: BorderRadius.circular(15), // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: petTheme.heartColor.withOpacity(0.2),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Service Icon
                                        Container(
                                          width: screenWidth * 0.15,
                                          height: screenWidth * 0.15,
                                          child: SvgPicture.asset(
                                            serviceSvg,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.04),
                                        // Package Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Package Name
                                              Text(
                                                package['name'],
                                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                                      fontSize: screenWidth * 0.05,
                                                      fontFamily: 'ComicNeue',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                              SizedBox(height: screenHeight * 0.005),
                                              // Pricing with Strikethrough
                                              Row(
                                                children: [
                                                  Text(
                                                    "SUBSCRIBE @\$${package['charge'].toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.04,
                                                      color: petTheme.heartColor,
                                                      fontFamily: 'ComicNeue',
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: screenWidth * 0.02),
                                                  Text(
                                                    "\$${(package['charge'] + 10).toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.035,
                                                      color: Colors.grey,
                                                      fontFamily: 'ComicNeue',
                                                      decoration: TextDecoration.lineThrough,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: screenHeight * 0.01),
                                              // Service List with Checkmarks
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: (package['description'] as String)
                                                    .split(', ')
                                                    .map((service) => Padding(
                                                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.check_circle,
                                                                size: screenWidth * 0.04,
                                                                color: Colors.grey[600],
                                                              ),
                                                              SizedBox(width: screenWidth * 0.02),
                                                              Text(
                                                                service,
                                                                style: TextStyle(
                                                                  fontSize: screenWidth * 0.035,
                                                                  color: Colors.grey[600],
                                                                  fontFamily: 'ComicNeue',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Select Button (Moved to bottom-right)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.04,
                                            vertical: screenHeight * 0.015,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFEF6C00), // Orange
                                                Color(0xFFFF80AB), // Pastel pink
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "Select package",
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.white,
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
                          ).animate().slideX(
                                begin: -0.5,
                                end: 0.0,
                                duration: 600.ms,
                                delay: 200.ms + (index * 100).ms,
                                curve: Curves.easeOutCubic,
                              ).fadeIn(
                                duration: 600.ms,
                                delay: 200.ms + (index * 100).ms,
                              ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}