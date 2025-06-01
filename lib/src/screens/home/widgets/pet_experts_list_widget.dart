import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/PetExpertsScreen.dart';

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
          height: screenHeight * 0.25, // Adjusted height for horizontal cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayedProviders.length,
            itemBuilder: (context, index) {
              final provider = displayedProviders[index];
              return Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.03),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Selected: ${provider['name']} (${provider['specialty']})"),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.45, // Fixed width for each card
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                                width: 4,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Theme.of(context).primaryColor.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: screenWidth * 0.07,
                              backgroundColor: const Color(0xFFFFF3F6),
                              child: Icon(
                                provider['icon'],
                                size: screenWidth * 0.08,
                                color: const Color(0xFFFF80AB),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            provider['name'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ComicNeue',
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            provider['specialty'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: Colors.grey[700],
                              fontFamily: 'ComicNeue',
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: screenWidth * 0.05,
                                color: const Color(0xFFFFB300),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                provider['rating'].toString(),
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'ComicNeue',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
      ],
    );
  }
}