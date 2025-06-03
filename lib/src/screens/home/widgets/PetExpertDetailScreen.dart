import 'package:flutter/material.dart';
import 'package:petbuddy/theme.dart'; // Import the theme for PetAppThemeExtension

class PetExpertDetailScreen extends StatelessWidget {
  final Map<String, dynamic> provider;

  const PetExpertDetailScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          provider['name'],
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.06,
                fontFamily: 'ComicNeue',
              ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expert Icon and Basic Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: petTheme.heartColor.withOpacity(0.2),
                        width: 4,
                      ),
                      color: Theme.of(context).cardTheme.color ?? Colors.white,
                    ),
                    child: CircleAvatar(
                      radius: screenWidth * 0.1,
                      backgroundColor: petTheme.boneColor.withOpacity(0.2),
                      child: Icon(
                        provider['icon'],
                        size: screenWidth * 0.12,
                        color: petTheme.heartColor,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider['name'],
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'ComicNeue',
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          provider['specialty'],
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'ComicNeue',
                              ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: screenWidth * 0.05,
                              color: const Color(0xFFFFB300),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              provider['rating'].toString(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: screenWidth * 0.04,
                                    fontFamily: 'ComicNeue',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              // Experience Section
              Text(
                "Experience",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color ?? Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: petTheme.heartColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  provider['experience']?.toString() ?? "10+ years in pet care and training",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: screenWidth * 0.035,
                        fontFamily: 'ComicNeue',
                      ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Work Details Section
              Text(
                "Work Details",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color ?? Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: petTheme.heartColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  provider['workDetails']?.toString() ??
                      "Specializes in behavior training, grooming, and veterinary consultations. Worked with over 500 pets, focusing on positive reinforcement techniques.",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: screenWidth * 0.035,
                        fontFamily: 'ComicNeue',
                      ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Book Appointment Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Booking appointment with ${provider['name']}..."),
                      ),
                    );
                  },
                  child: Text(
                    "Book Appointment",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontFamily: 'ComicNeue',
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}