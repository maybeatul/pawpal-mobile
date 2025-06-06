// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:petbuddy/src/screens/booking/bookings_screen.dart';
// import 'package:petbuddy/src/screens/home/home_screen.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   // List of screens to switch between (exactly three screens)
//   final List<Widget> _screens = [
//     HomeScreen(),
//     const BookingsScreen(), // BookingsScreen (to be implemented)
//     const Placeholder(), // ChatScreen (to be implemented)
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Theme.of(context).scaffoldBackgroundColor, // #E6F0FA
//               const Color(0xFFFFF3E0), // Light peach
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           items: <BottomNavigationBarItem>[
//             // Home Tab
//             BottomNavigationBarItem(
//               icon: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: _selectedIndex == 0
//                           ? const LinearGradient(
//                               colors: [
//                                 Color(0xFFEF6C00), // Orange
//                                 Color(0xFFFF80AB), // Pastel pink
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             )
//                           : null,
//                       boxShadow: _selectedIndex == 0
//                           ? [
//                               BoxShadow(
//                                 color: Theme.of(context).primaryColor.withOpacity(0.4),
//                                 blurRadius: 12,
//                                 spreadRadius: 2,
//                               ),
//                             ]
//                           : [],
//                     ),
//                     child: Icon(
//                       Icons.pets,
//                       size: screenWidth * 0.07,
//                       color: _selectedIndex == 0
//                           ? Colors.white
//                           : Theme.of(context).primaryColor.withOpacity(0.5),
//                     ),
//                   ),
//                   // Sparkle effects around the selected icon
//                   if (_selectedIndex == 0) ...[
//                     // Positioned(
//                     //   top: -5,
//                     //   left: -5,
//                     //   child: Icon(
//                     //     Icons.star,
//                     //     size: screenWidth * 0.04,
//                     //     color: const Color(0xFFFFE082),
//                     //   ).animate().fadeIn(delay: 200.ms).scale(
//                     //         begin: const Offset(0.5, 0.5),
//                     //         end: const Offset(1.0, 1.0),
//                     //         duration: 600.ms,
//                     //         curve: Curves.bounceOut,
//                     //         // repeat: RepeatMode.reverse,
//                     //       ),
//                     // ),
//                     Positioned(
//                       bottom: -5,
//                       right: -5,
//                       child: Icon(
//                         Icons.star,
//                         size: screenWidth * 0.03,
//                         color: const Color(0xFFFFE082),
//                       ).animate().fadeIn(delay: 400.ms).scale(
//                             begin: const Offset(0.5, 0.5),
//                             end: const Offset(1.0, 1.0),
//                             duration: 600.ms,
//                             curve: Curves.bounceOut,
//                             // repeat: RepeatMode.reverse,
//                           ),
                    
                    
//                     ),
//                   ],
//                   // Cute pet accessory (bone) above the icon
//                   if (_selectedIndex == 0)
//                     Positioned(
//                       top: -15,
//                       child: Icon(
//                         Icons.toys,
//                         size: screenWidth * 0.04,
//                         color: Theme.of(context).primaryColor,
//                       ).animate().moveY(
//                             begin: 0,
//                             end: -5,
//                             duration: 500.ms,
//                             curve: Curves.easeInOut,
//                             // repeat: RepeatMode.reverse,
//                           ).shake(
//                             duration: 600.ms,
//                             hz: 2,
//                             rotation: 0.05,
//                           ),
//                     ),
//                 ],
//               ).animate().scale(
//                     duration: 400.ms,
//                     curve: Curves.bounceOut,
//                     begin: _selectedIndex == 0 ? const Offset(1.0, 1.0) : const Offset(0.8, 0.8),
//                     end: _selectedIndex == 0 ? const Offset(1.2, 1.2) : const Offset(1.0, 1.0),
//                   ).shake(
//                     duration: 500.ms,
//                     hz: 3,
//                     rotation: 0.05,
//                   ),
//               label: '',
//             ),
//             // Bookings Tab
//             BottomNavigationBarItem(
//               icon: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: _selectedIndex == 1
//                           ? const LinearGradient(
//                               colors: [
//                                 Color(0xFFEF6C00),
//                                 Color(0xFFFF80AB),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             )
//                           : null,
//                       boxShadow: _selectedIndex == 1
//                           ? [
//                               BoxShadow(
//                                 color: Theme.of(context).primaryColor.withOpacity(0.4),
//                                 blurRadius: 12,
//                                 spreadRadius: 2,
//                               ),
//                             ]
//                           : [],
//                     ),
//                     child: Icon(
//                       Icons.event,
//                       size: screenWidth * 0.07,
//                       color: _selectedIndex == 1
//                           ? Colors.white
//                           : Theme.of(context).primaryColor.withOpacity(0.5),
//                     ),
//                   ),
//                   if (_selectedIndex == 1) ...[
//                     Positioned(
//                       top: -5,
//                       left: -5,
//                       child: Icon(
//                         Icons.star,
//                         size: screenWidth * 0.04,
//                         color: const Color(0xFFFFE082),
//                       ).animate().fadeIn(delay: 200.ms).scale(
//                             begin: const Offset(0.5, 0.5),
//                             end: const Offset(1.0, 1.0),
//                             duration: 600.ms,
//                             curve: Curves.bounceOut,
//                             // repeat: RepeatMode.reverse,
//                           ),
//                     ),
//                     Positioned(
//                       bottom: -5,
//                       right: -5,
//                       child: Icon(
//                         Icons.star,
//                         size: screenWidth * 0.03,
//                         color: const Color(0xFFFFE082),
//                       ).animate().fadeIn(delay: 400.ms).scale(
//                             begin: const Offset(0.5, 0.5),
//                             end: const Offset(1.0, 1.0),
//                             duration: 600.ms,
//                             curve: Curves.bounceOut,
//                             // repeat: RepeatMode.reverse,
//                           ),
//                     ),
//                   ],
//                   if (_selectedIndex == 1)
//                     Positioned(
//                       top: -15,
//                       child: Icon(
//                         Icons.favorite,
//                         size: screenWidth * 0.04,
//                         color: Theme.of(context).primaryColor,
//                       ).animate().moveY(
//                             begin: 0,
//                             end: -5,
//                             duration: 500.ms,
//                             curve: Curves.easeInOut,
//                             // repeat: RepeatMode.reverse,
//                           ).shake(
//                             duration: 600.ms,
//                             hz: 2,
//                             rotation: 0.05,
//                           ),
//                     ),
//                 ],
//               ).animate().scale(
//                     duration: 400.ms,
//                     curve: Curves.bounceOut,
//                     begin: _selectedIndex == 1 ? const Offset(1.0, 1.0) : const Offset(0.8, 0.8),
//                     end: _selectedIndex == 1 ? const Offset(1.2, 1.2) : const Offset(1.0, 1.0),
//                   ).shake(
//                     duration: 500.ms,
//                     hz: 3,
//                     rotation: 0.05,
//                   ),
//               label: '',
//             ),
//             // Chat Tab
//             BottomNavigationBarItem(
//               icon: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: _selectedIndex == 2
//                           ? const LinearGradient(
//                               colors: [
//                                 Color(0xFFEF6C00),
//                                 Color(0xFFFF80AB),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             )
//                           : null,
//                       boxShadow: _selectedIndex == 2
//                           ? [
//                               BoxShadow(
//                                 color: Theme.of(context).primaryColor.withOpacity(0.4),
//                                 blurRadius: 12,
//                                 spreadRadius: 2,
//                               ),
//                             ]
//                           : [],
//                     ),
//                     child: Icon(
//                       Icons.chat_bubble,
//                       size: screenWidth * 0.07,
//                       color: _selectedIndex == 2
//                           ? Colors.white
//                           : Theme.of(context).primaryColor.withOpacity(0.5),
//                     ),
//                   ),
//                   if (_selectedIndex == 2) ...[
//                     Positioned(
//                       top: -5,
//                       left: -5,
//                       child: Icon(
//                         Icons.star,
//                         size: screenWidth * 0.04,
//                         color: const Color(0xFFFFE082),
//                       ).animate().fadeIn(delay: 200.ms).scale(
//                             begin: const Offset(0.5, 0.5),
//                             end: const Offset(1.0, 1.0),
//                             duration: 600.ms,
//                             curve: Curves.bounceOut,
//                             // repeat: RepeatMode.reverse,
//                           ),
//                     ),
//                     Positioned(
//                       bottom: -5,
//                       right: -5,
//                       child: Icon(
//                         Icons.star,
//                         size: screenWidth * 0.03,
//                         color: const Color(0xFFFFE082),
//                       ).animate().fadeIn(delay: 400.ms).scale(
//                             begin: const Offset(0.5, 0.5),
//                             end: const Offset(1.0, 1.0),
//                             duration: 600.ms,
//                             curve: Curves.bounceOut,
//                             // repeat: RepeatMode.reverse,
//                           ),
//                     ),
//                   ],
//                   if (_selectedIndex == 2)
//                     Positioned(
//                       top: -15,
//                       child: Icon(
//                         Icons.message,
//                         size: screenWidth * 0.04,
//                         color: Theme.of(context).primaryColor,
//                       ).animate().moveY(
//                             begin: 0,
//                             end: -5,
//                             duration: 500.ms,
//                             curve: Curves.easeInOut,
//                             // repeat: RepeatMode.reverse,
//                           ).shake(
//                             duration: 600.ms,
//                             hz: 2,
//                             rotation: 0.05,
//                           ),
//                     ),
//                 ],
//               ).animate().scale(
//                     duration: 400.ms,
//                     curve: Curves.bounceOut,
//                     begin: _selectedIndex == 2 ? const Offset(1.0, 1.0) : const Offset(0.8, 0.8),
//                     end: _selectedIndex == 2 ? const Offset(1.2, 1.2) : const Offset(1.0, 1.0),
//                   ).shake(
//                     duration: 500.ms,
//                     hz: 3,
//                     rotation: 0.05,
//                   ),
//               label: '',
//             ),
            
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Theme.of(context).primaryColor,
//           unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.5),
//           backgroundColor: Colors.transparent, // Transparent to show the container's gradient
//           type: BottomNavigationBarType.fixed,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/booking/my_bookings_screen.dart';
import 'package:petbuddy/src/screens/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to switch between (four screens)
  final List<Widget> _screens = [
    HomeScreen(),
    const MyBookingsScreen(), // BookingsScreen
    const Placeholder(), // ChatScreen
    const Placeholder(),
    const Placeholder(), // My Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor, // #E6F0FA
              const Color(0xFFFFF3E0), // Light peach
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            // Home Tab
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _selectedIndex == 0
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFEF6C00), // Orange
                            Color(0xFFFF80AB), // Pastel pink
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  boxShadow: _selectedIndex == 0
                      ? [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.pets,
                  size: screenWidth * 0.07,
                  color: _selectedIndex == 0
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
              label: '',
            ),
            // Bookings Tab
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _selectedIndex == 1
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFEF6C00),
                            Color(0xFFFF80AB),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  boxShadow: _selectedIndex == 1
                      ? [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.event,
                  size: screenWidth * 0.07,
                  color: _selectedIndex == 1
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
              label: '',
            ),
            // Chat Tab
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _selectedIndex == 2
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFEF6C00),
                            Color(0xFFFF80AB),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  boxShadow: _selectedIndex == 2
                      ? [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.chat_bubble,
                  size: screenWidth * 0.07,
                  color: _selectedIndex == 2
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
              label: '',
            ),
            // My Profile Tab
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _selectedIndex == 3
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFEF6C00),
                            Color(0xFFFF80AB),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  boxShadow: _selectedIndex == 3
                      ? [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  Icons.person,
                  size: screenWidth * 0.07,
                  color: _selectedIndex == 3
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.5),
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}