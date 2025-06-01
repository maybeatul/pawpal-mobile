import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  // Sample list of upcoming bookings
  final List<Map<String, dynamic>> bookings = const [
    {
      'provider': 'Alice Smith',
      'service': 'Grooming',
      'date': 'May 16, 2025',
      'time': '10:00 AM',
      'icon': Icons.cut,
    },
    {
      'provider': 'Dr. John Doe',
      'service': 'Vet Checkup',
      'date': 'May 17, 2025',
      'time': '2:00 PM',
      'icon': Icons.local_hospital,
    },
    {
      'provider': 'Emma Brown',
      'service': 'Training',
      'date': 'May 18, 2025',
      'time': '11:00 AM',
      'icon': Icons.school,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // #E6F0FA
      body: Stack(
        children: [
          // Background paw print trail
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            child: Row(
              children: List.generate(4, (index) => Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.15),
                child: Icon(
                  Icons.pets,
                  size: screenWidth * 0.05,
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ).animate().fadeIn(delay: (800 + index * 200).ms).moveX(
                      begin: -20,
                      end: screenWidth,
                      duration: 3000.ms,
                      curve: Curves.easeInOut,
                    ),
              )),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My Bookings",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              fontSize: screenWidth * 0.07,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Icon(
                        Icons.event,
                        size: screenWidth * 0.05,
                        color: Theme.of(context).primaryColor,
                      ).animate().shake(
                            duration: 600.ms,
                            hz: 2,
                            rotation: 0.05,
                            // repeat: RepeatMode.reverse,
                          ),
                    ],
                  ).animate().fadeIn(duration: 600.ms),
                  SizedBox(height: screenHeight * 0.03),
                  // Upcoming Bookings List
                  bookings.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.1),
                              Icon(
                                Icons.event_busy,
                                size: screenWidth * 0.15,
                                color: Theme.of(context).primaryColor.withOpacity(0.5),
                              ).animate().fadeIn(delay: 800.ms),
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                "No bookings yet!",
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontSize: screenWidth * 0.05,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ).animate().fadeIn(delay: 1000.ms),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                "Book a service to get started",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.grey[600],
                                    ),
                              ).animate().fadeIn(delay: 1200.ms),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            final booking = bookings[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Booking: ${booking['service']} with ${booking['provider']}"),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.04),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor.withOpacity(0.05),
                                        Colors.white,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Booking Avatar
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: screenWidth * 0.15,
                                            height: screenWidth * 0.15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                                            ),
                                            child: Icon(
                                              booking['icon'],
                                              size: screenWidth * 0.08,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Icon(
                                              Icons.favorite,
                                              size: screenWidth * 0.04,
                                              color: Theme.of(context).primaryColor.withOpacity(0.7),
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
                                            begin: const Offset(0.9, 0.9),
                                            end: const Offset(1.0, 1.0),
                                            duration: 600.ms,
                                            curve: Curves.bounceOut,
                                          ),
                                      SizedBox(width: screenWidth * 0.04),
                                      // Booking Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              booking['service'],
                                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                                    fontSize: screenWidth * 0.045,
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: screenHeight * 0.005),
                                            Text(
                                              "with ${booking['provider']}",
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    fontSize: screenWidth * 0.035,
                                                    color: Colors.grey[600],
                                                  ),
                                            ),
                                            SizedBox(height: screenHeight * 0.005),
                                            Text(
                                              "${booking['date']} at ${booking['time']}",
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                    fontSize: screenWidth * 0.035,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(delay: (800 + index * 200).ms).slideY(
                                      begin: 0.3,
                                      end: 0,
                                      duration: 600.ms,
                                    ),
                              ),
                            );
                          },
                        ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Book a new service!"),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ).animate().scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            duration: 800.ms,
            curve: Curves.bounceOut,
          ),
    );
  }
}