import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/PetExpertsScreen.dart';
import 'package:petbuddy/src/screens/home/widgets/PetExpertDetailScreen.dart';
import 'package:petbuddy/theme.dart'; // Import the theme for PetAppThemeExtension

class PetExpertsListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> providers;
  final int maxItems;

  const PetExpertsListWidget({
    super.key,
    required this.providers,
    this.maxItems = 6,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final displayedProviders = providers.take(maxItems).toList();
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!; // Access the theme

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Our Pet Experts 🐾",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: screenWidth * 0.05,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'ComicNeue',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetExpertsScreen(providers: providers),
                  ),
                );
              },
              child: Text(
                "See More",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          height: screenHeight * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            itemCount: displayedProviders.length,
            itemBuilder: (context, index) {
              final provider = displayedProviders[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.015,
                  vertical: screenHeight * 0.01,
                ),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Selected: ${provider['name']} (${provider['specialty']})"),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.55,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color ?? Colors.white, // Use card theme color
                      borderRadius: BorderRadius.circular(15),
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
                              // Expert Icon
                              Container(
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: petTheme.heartColor.withOpacity(0.2),
                                    width: 4,
                                  ),
                                  color: Theme.of(context).cardTheme.color ?? Colors.white, // Use card theme color
                                ),
                                child: CircleAvatar(
                                  radius: screenWidth * 0.07,
                                  backgroundColor: petTheme.boneColor.withOpacity(0.2),
                                  child: Icon(
                                    provider['icon'],
                                    size: screenWidth * 0.08,
                                    color: petTheme.heartColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              // Expert Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name
                                    Text(
                                      provider['name'],
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: screenWidth * 0.045,
                                            color: Theme.of(context).textTheme.bodyMedium!.color,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'ComicNeue',
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    // Specialty
                                    Text(
                                      provider['specialty'],
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontSize: screenWidth * 0.035,
                                            color: Theme.of(context).textTheme.bodySmall!.color,
                                            fontFamily: 'ComicNeue',
                                            fontWeight: FontWeight.w500,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    // Rating
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: screenWidth * 0.04,
                                          color: const Color(0xFFFFB300),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Text(
                                          provider['rating'].toString(),
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                fontSize: screenWidth * 0.035,
                                                color: Theme.of(context).textTheme.bodySmall!.color,
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
                          // Know More Button (Bottom-right)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: screenHeight * 0.02),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PetExpertDetailScreen(provider: provider),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                    vertical: screenHeight * 0.015,
                                  ),
                                  decoration: BoxDecoration(
                                    color: petTheme.heartColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "Know More",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                          fontSize: screenWidth * 0.035,
                                          color: Colors.white,
                                          fontFamily: 'ComicNeue',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}