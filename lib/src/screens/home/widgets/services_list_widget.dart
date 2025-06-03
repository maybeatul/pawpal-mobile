// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:petbuddy/src/screens/services/ServiceDetailScreen.dart';


// class ServicesListWidget extends StatefulWidget {
//   final List<Map<String, dynamic>> services;

//   const ServicesListWidget({super.key, required this.services});

//   @override
//   _ServicesListWidgetState createState() => _ServicesListWidgetState();
// }

// class _ServicesListWidgetState extends State<ServicesListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return SizedBox(
//       height: screenHeight * 0.20,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.services.length,
//         itemBuilder: (context, index) {
//           bool showPawPrints = false;
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Padding(
//                 padding: EdgeInsets.only(right: screenWidth * 0.03),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       showPawPrints = true;
//                     });
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ServiceDetailScreen(
//                           serviceTitle: widget.services[index]['title'],
//                           serviceIcon: widget.services[index]['icon'],
//                           serviceSvg: widget.services[index]['svg'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     clipBehavior: Clip.none,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(screenWidth * 0.02),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   const Color(0xFFFF80AB).withOpacity(0.2),
//                                   Theme.of(context).primaryColor.withOpacity(0.2),
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Theme.of(context).primaryColor.withOpacity(0.1),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: SvgPicture.asset(
//                               widget.services[index]['svg'],
//                               height: screenWidth * 0.16,
//                               width: screenWidth * 0.16,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.01),
//                           Text(
//                             widget.services[index]['title'],
//                             style: TextStyle(
//                               fontSize: screenWidth * 0.035,
//                               color: Theme.of(context).primaryColor,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'ComicNeue',
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                       if (showPawPrints)
//                         Positioned(
//                           top: -screenWidth * 0.05,
//                           left: -screenWidth * 0.05,
//                           child: Row(
//                             children: List.generate(3, (pawIndex) => Padding(
//                               padding: EdgeInsets.only(left: screenWidth * 0.03),
//                               child: Icon(
//                                 Icons.pets,
//                                 size: screenWidth * 0.03,
//                                 color: const Color(0xFFFF80AB).withOpacity(0.5),
//                               ),
//                             )),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy/src/screens/services/ServiceDetailScreen.dart';
import 'package:petbuddy/theme.dart'; // Import the theme for PetAppThemeExtension

class ServicesListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> services;

  const ServicesListWidget({super.key, required this.services});

  @override
  _ServicesListWidgetState createState() => _ServicesListWidgetState();
}

class _ServicesListWidgetState extends State<ServicesListWidget> {
  // Track which item should show paw prints
  Map<int, bool> showPawPrintsMap = {};

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true, // Allow the grid to take only the space it needs
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: screenWidth * 0.03, // Space between columns
        mainAxisSpacing: screenHeight * 0.00, // Space between rows
        childAspectRatio: 0.8, // Adjust the aspect ratio for better fit
      ),
      itemCount: widget.services.length,
      itemBuilder: (context, index) {
        bool showPawPrints = showPawPrintsMap[index] ?? false;
        return GestureDetector(
          onTap: () {
            setState(() {
              showPawPrintsMap[index] = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceDetailScreen(
                  serviceTitle: widget.services[index]['title'],
                  serviceIcon: widget.services[index]['icon'],
                  serviceSvg: widget.services[index]['svg'],
                ),
              ),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF80AB).withOpacity(0.2),
                          Theme.of(context).primaryColor.withOpacity(0.2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      widget.services[index]['svg'],
                      height: screenWidth * 0.16,
                      width: screenWidth * 0.16,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    widget.services[index]['title'],
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'ComicNeue',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              // if (showPawPrints)
              //   Positioned(
              //     top: -screenWidth * 0.05,
              //     left: -screenWidth * 0.05,
              //     child: Row(
              //       children: List.generate(
              //         3,
              //         (pawIndex) => Padding(
              //           padding: EdgeInsets.only(left: screenWidth * 0.03),
              //           child: Icon(
              //             Icons.pets,
              //             size: screenWidth * 0.03,
              //             color: const Color(0xFFFF80AB).withOpacity(0.5),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }
}