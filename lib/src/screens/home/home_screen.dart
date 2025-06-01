import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy/src/screens/home/AddPetsScreen.dart';
import 'package:petbuddy/src/screens/services/ServiceDetailScreen.dart';
 // Added import for AddPetsScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';
  final String userName = "Alex";

  final List<String> filters = [
    'All',
    'Groomers',
    'Vets',
    'Trainers',
    'Sitters',
    'Walkers',
  ];

  final List<Map<String, dynamic>> services = [
    {'title': 'Grooming 🐩', 'icon': Icons.cut, 'svg': 'assets/illustrations/undraw_good-doggy_4ast.svg'},
    {'title': 'Vet Care 🩺', 'icon': Icons.local_hospital, 'svg': 'assets/illustrations/undraw_dog_jfxm.svg'},
    {'title': 'Training 🎾', 'icon': Icons.school, 'svg': 'assets/illustrations/undraw_playing-fetch_x508.svg'},
    {'title': 'Pet Sitting 🐾', 'icon': Icons.pets, 'svg': 'assets/illustrations/undraw_relaxing-walk_hvua.svg'},
    {'title': 'Dog Walking 🚶', 'icon': Icons.directions_walk, 'svg': 'assets/illustrations/undraw_dog-walking_w27q.svg'},
    {'title': 'Pet Boarding 🏡', 'icon': Icons.hotel, 'svg': 'assets/illustrations/undraw_dog-walking_w27q_1.svg'},
  ];

  final List<Map<String, dynamic>> providers = [
    {'name': 'Alice Smith', 'specialty': 'Groomers', 'rating': 4.8, 'icon': Icons.cut},
    {'name': 'Dr. John Doe', 'specialty': 'Vets', 'rating': 4.9, 'icon': Icons.local_hospital},
    {'name': 'Emma Brown', 'specialty': 'Trainers', 'rating': 4.7, 'icon': Icons.school},
    {'name': 'Mike Wilson', 'specialty': 'Sitters', 'rating': 4.6, 'icon': Icons.pets},
    {'name': 'Sarah Davis', 'specialty': 'Walkers', 'rating': 4.5, 'icon': Icons.directions_walk},
    {'name': 'Dr. Linda Green', 'specialty': 'Vets', 'rating': 4.8, 'icon': Icons.local_hospital},
    {'name': 'Tom Harris', 'specialty': 'Groomers', 'rating': 4.7, 'icon': Icons.cut},
    {'name': 'Kelly Adams', 'specialty': 'Trainers', 'rating': 4.9, 'icon': Icons.school},
  ];

  // New: Sample pets list (to be replaced with backend/storage)
  final List<Map<String, dynamic>> _pets = [
    {'name': 'Luna', 'type': 'Cat', 'svg': 'assets/illustrations/cat.svg'},
    {'name': 'Max', 'type': 'Dog', 'svg': 'assets/illustrations/dog.svg'},
  ];

  List<Map<String, dynamic>> get filteredProviders {
    return providers.where((provider) {
      final matchesFilter = _selectedFilter == 'All' || provider['specialty'] == _selectedFilter;
      final matchesSearch = provider['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          provider['specialty'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Row(
              children: [
                Text(
                  "PawPal",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: screenWidth * 0.06,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'ComicNeue',
                      ),
                ),
                SizedBox(width: screenWidth * 0.02),
                // Icon(
                //   Icons.pets,
                //   size: screenWidth * 0.05,
                //   color: Theme.of(context).primaryColor,
                // ).animate().shake(
                //       duration: 600.ms,
                //       hz: 2,
                //       rotation: 0.05,
                //     ),
              ],
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(
              "Welcome, $userName",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'ComicNeue',
                  ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.05),
            child: IconButton(
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    size: screenWidth * 0.07,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: screenWidth * 0.025,
                      height: screenWidth * 0.025,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.red,
                      ),
                    ).animate().scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1.2, 1.2),
                          duration: 800.ms,
                          curve: Curves.bounceOut,
                        ),
                  ),
                ],
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Notifications"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
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
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.pets,
                        size: screenWidth * 0.06,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Find a service or provider...',
                      hintStyle: TextStyle(
                        fontFamily: 'ComicNeue',
                        color: Colors.grey[400],
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.0, 1.0),
                        duration: 600.ms,
                        curve: Curves.bounceOut,
                      ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "Our Services 🐶",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.05,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn(delay: 1000.ms),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        bool showPawPrints = false;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                              padding: EdgeInsets.only(right: screenWidth * 0.03),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPawPrints = true;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceDetailScreen(
                                        serviceTitle: services[index]['title'],
                                        serviceIcon: services[index]['icon'],
                                        serviceSvg: services[index]['svg'],
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
                                            services[index]['svg'],
                                            height: screenWidth * 0.16,
                                            width: screenWidth * 0.16,
                                            fit: BoxFit.contain,
                                          ).animate().scale(
                                                begin: const Offset(0.8, 0.8),
                                                end: const Offset(1.0, 1.0),
                                                duration: 600.ms,
                                                curve: Curves.bounceOut,
                                              ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text(
                                          services[index]['title'],
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'ComicNeue',
                                          ),
                                          textAlign: TextAlign.center,
                                        ).animate().shake(
                                              duration: 800.ms,
                                              hz: 2,
                                              rotation: 0.03,
                                            ),
                                      ],
                                    ),
                                    if (showPawPrints)
                                      Positioned(
                                        top: -screenWidth * 0.05,
                                        left: -screenWidth * 0.05,
                                        child: Row(
                                          children: List.generate(3, (pawIndex) => Padding(
                                            padding: EdgeInsets.only(left: screenWidth * 0.03),
                                            child: Icon(
                                              Icons.pets,
                                              size: screenWidth * 0.03,
                                              color: const Color(0xFFFF80AB).withOpacity(0.5),
                                            ).animate().fadeIn(
                                                  delay: (100 + pawIndex * 100).ms,
                                                  duration: 300.ms,
                                                ).move(
                                                  begin: const Offset(0, 0),
                                                  end: Offset(screenWidth * 0.05 * (pawIndex + 1), -screenWidth * 0.05),
                                                  duration: 600.ms,
                                                  curve: Curves.easeOut,
                                                ),
                                          )),
                                        ),
                                      ),
                                  ],
                                ).animate().fadeIn(delay: (1200 + index * 200).ms),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // New: My Pets Section
                  Text(
                    "My Pets 🐾",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.05,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn(delay: 1400.ms),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _pets.length + 1, // +1 for the "+" button
                      itemBuilder: (context, index) {
                        if (index == _pets.length) {
                          // "+" button card
                          return Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.03),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddPetsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: screenWidth * 0.08,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      'Add Pet',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: screenWidth * 0.035,
                                            color: Theme.of(context).primaryColor,
                                            fontFamily: 'ComicNeue',
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(delay: (1500 + index * 100).ms),
                            ),
                          );
                        }
                        // Pet card
                        final pet = _pets[index];
                        return Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.03),
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.pets,
                                        size: screenWidth * 0.05,
                                        color: Colors.white,
                                      ).animate().scale(
                                            begin: const Offset(0.8, 0.8),
                                            end: const Offset(1.0, 1.0),
                                            duration: 300.ms,
                                          ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Expanded(
                                        child: Text(
                                          'Selected: ${pet['name']} (${pet['type']})',
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontFamily: 'ComicNeue',
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Theme.of(context).primaryColor,
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.02),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        pet['svg'],
                                        height: screenWidth * 0.08,
                                        width: screenWidth * 0.08,
                                        fit: BoxFit.contain,
                                      ).animate().fadeIn(
                                            duration: 400.ms,
                                            delay: (1500 + index * 100).ms,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: Text(
                                      pet['name'],
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: screenWidth * 0.035,
                                            color: Theme.of(context).primaryColor,
                                            fontFamily: 'ComicNeue',
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: Text(
                                      pet['type'],
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.grey[600],
                                            fontFamily: 'ComicNeue',
                                          ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(delay: (1500 + index * 100).ms),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Existing Filter Section
                  SizedBox(
                    height: screenHeight * 0.05,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedFilter == filters[index];
                        return Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.03),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFilter = filters[index];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.01,
                              ),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          const Color(0xFFFF80AB),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                color: isSelected ? null : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
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
                                  Text(
                                    filters[index],
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: screenWidth * 0.035,
                                          color: isSelected
                                              ? Colors.white
                                              : Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'ComicNeue',
                                        ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(width: screenWidth * 0.02),
                                    Icon(
                                      Icons.pets,
                                      size: screenWidth * 0.04,
                                      color: Colors.white,
                                    ).animate().shake(
                                          duration: 600.ms,
                                          hz: 2,
                                          rotation: 0.05,
                                        ),
                                  ],
                                ],
                              ),
                            ).animate().fadeIn(delay: (1800 + index * 100).ms).scale(
                                  begin: const Offset(0.9, 0.9),
                                  end: const Offset(1.0, 1.0),
                                  duration: 400.ms,
                                  curve: Curves.bounceOut,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "Our Pet Experts 🐾",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.05,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue', // Changed from Poppins to ComicNeue for consistency
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn(delay: 2200.ms),
                  SizedBox(height: screenHeight * 0.02),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      final provider = filteredProviders[index];
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Selected: ${provider['name']} (${provider['specialty']})"),
                            ),
                          );
                        },
                        child: Container(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: screenHeight * 0.02),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.2,
                                      height: screenWidth * 0.2,
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
                                        radius: screenWidth * 0.09,
                                        backgroundColor: const Color(0xFFFFF3F6),
                                        child: Icon(
                                          provider['icon'],
                                          size: screenWidth * 0.1,
                                          color: const Color(0xFFFF80AB),
                                        ),
                                      ),
                                    ).animate().scale(
                                          begin: const Offset(0.9, 0.9),
                                          end: const Offset(1.0, 1.0),
                                          duration: 600.ms,
                                          curve: Curves.bounceOut,
                                        ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.pets,
                                          size: screenWidth * 0.035,
                                          color: Colors.white,
                                        ),
                                      ).animate().shake(
                                            duration: 800.ms,
                                            hz: 2,
                                            rotation: 0.03,
                                          ),
                                    ),
                                  ],
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
                              const Spacer(),
                              // Removed Contact Button for simplicity
                            ],
                          ),
                        ).animate().fadeIn(delay: (2400 + index * 200).ms).slideY(
                              begin: 0.3,
                              end: 0,
                              duration: 600.ms,
                            ).then().shake(
                              duration: 400.ms,
                              hz: 1,
                              rotation: 0.02,
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}