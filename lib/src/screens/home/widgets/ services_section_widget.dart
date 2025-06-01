import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/widgets/services_list_widget.dart';

class ServicesSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> services;

  const ServicesSectionWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Services 🐶",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.05,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: screenHeight * 0.02),
        ServicesListWidget(services: services),
      ],
    );
  }
}