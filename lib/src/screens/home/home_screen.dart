import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/widgets/%20pet_products_list_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/%20services_section_widget.dart';

import 'package:petbuddy/src/screens/home/widgets/search_bar_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/filter_chips_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/pet_experts_list_widget.dart';


/// The main home screen of the PetBuddy app, displaying search, services, filters, pet experts, and products.
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

  // Filter options for pet experts
  final List<String> filters = [
    'All',
    'Groomers',
    'Vets',
    'Trainers',
    'Sitters',
    'Walkers',
  ];

  // List of available services (replaced problematic SVG with placeholder icon)
  final List<Map<String, dynamic>> services = [
    {'title': 'Grooming', 'icon': Icons.cut, 'svg': 'assets/illustrations/undraw_good-doggy_4ast.svg'},
    {'title': 'Vet Care', 'icon': Icons.local_hospital, 'svg': 'assets/illustrations/undraw_dog_jfxm.svg'},
    {'title': 'Training', 'icon': Icons.school, 'svg': 'assets/illustrations/undraw_playing-fetch_x508.svg'},
    {'title': 'Pet Sitting', 'icon': Icons.pets, 'svg': 'assets/illustrations/undraw_relaxing-walk_hvua.svg'},
    {'title': 'Dog Walking', 'icon': Icons.directions_walk, 'svg': 'assets/illustrations/undraw_dog-walking_w27q.svg'},
    {'title': 'Pet Boarding', 'icon': Icons.hotel, 'svg': ''}, // Placeholder: empty SVG path
  ];

  // List of pet expert providers
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

  // List of pet products (20 items)
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Squeaky Ball',
      'category': 'Toys',
      'price': 5.99,
      'icon': Icons.toys,
      'description': 'Durable rubber ball with a fun squeak for dogs.',
    },
    {
      'name': 'Organic Dog Food',
      'category': 'Food',
      'price': 29.99,
      'icon': Icons.restaurant,
      'description': 'High-quality organic kibble for all breeds.',
    },
    {
      'name': 'Cat Scratching Post',
      'category': 'Accessories',
      'price': 19.99,
      'icon': Icons.pets,
      'description': 'Sturdy scratching post to keep cats entertained.',
    },
    {
      'name': 'Pet Grooming Brush',
      'category': 'Grooming',
      'price': 12.99,
      'icon': Icons.brush,
      'description': 'Gentle brush for dogs and cats.',
    },
    {
      'name': 'Tennis Ball Launcher',
      'category': 'Toys',
      'price': 15.99,
      'icon': Icons.toys,
      'description': 'Automatic launcher for fetch games.',
    },
    {
      'name': 'Grain-Free Cat Food',
      'category': 'Food',
      'price': 24.99,
      'icon': Icons.restaurant,
      'description': 'Nutritious wet food for cats.',
    },
    {
      'name': 'Dog Leash',
      'category': 'Accessories',
      'price': 9.99,
      'icon': Icons.pets,
      'description': 'Strong nylon leash for daily walks.',
    },
    {
      'name': 'Pet Shampoo',
      'category': 'Grooming',
      'price': 8.99,
      'icon': Icons.brush,
      'description': 'Soothing shampoo for sensitive skin.',
    },
    {
      'name': 'Chew Bone',
      'category': 'Toys',
      'price': 7.99,
      'icon': Icons.toys,
      'description': 'Long-lasting chew toy for dogs.',
    },
    {
      'name': 'Puppy Training Treats',
      'category': 'Food',
      'price': 6.99,
      'icon': Icons.restaurant,
      'description': 'Small treats for training sessions.',
    },
    {
      'name': 'Cat Collar',
      'category': 'Accessories',
      'price': 4.99,
      'icon': Icons.pets,
      'description': 'Adjustable collar with bell.',
    },
    {
      'name': 'Nail Clippers',
      'category': 'Grooming',
      'price': 11.99,
      'icon': Icons.brush,
      'description': 'Safe clippers for pet nails.',
    },
    {
      'name': 'Plush Toy',
      'category': 'Toys',
      'price': 9.99,
      'icon': Icons.toys,
      'description': 'Soft toy for cuddly pets.',
    },
    {
      'name': 'Senior Dog Food',
      'category': 'Food',
      'price': 27.99,
      'icon': Icons.restaurant,
      'description': 'Specially formulated for older dogs.',
    },
    {
      'name': 'Pet Bed',
      'category': 'Accessories',
      'price': 39.99,
      'icon': Icons.pets,
      'description': 'Cozy bed for dogs and cats.',
    },
    {
      'name': 'Flea Comb',
      'category': 'Grooming',
      'price': 6.99,
      'icon': Icons.brush,
      'description': 'Fine-tooth comb for flea removal.',
    },
    {
      'name': 'Interactive Puzzle Toy',
      'category': 'Toys',
      'price': 14.99,
      'icon': Icons.toys,
      'description': 'Mental stimulation toy for dogs.',
    },
    {
      'name': 'Kitten Milk Formula',
      'category': 'Food',
      'price': 19.99,
      'icon': Icons.restaurant,
      'description': 'Nutritional formula for young kittens.',
    },
    {
      'name': 'Dog Harness',
      'category': 'Accessories',
      'price': 17.99,
      'icon': Icons.pets,
      'description': 'Comfortable harness for walks.',
    },
    {
      'name': 'Ear Cleaner',
      'category': 'Grooming',
      'price': 9.99,
      'icon': Icons.brush,
      'description': 'Gentle solution for pet ear hygiene.',
    },
  ];

  // Unused pets list (placeholder for future section)
  final List<Map<String, dynamic>> _pets = [
    {'name': 'Luna', 'type': 'Cat', 'svg': 'assets/illustrations/cat.svg'},
    {'name': 'Max', 'type': 'Dog', 'svg': 'assets/illustrations/dog.svg'},
  ];

  /// Computed property to filter providers based on search and filter
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
    // Update search query for providers
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

    // Debug print to verify rendering
    print('Building HomeScreen with ${products.length} products and ${filteredProviders.length} providers');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "PawPal",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: screenWidth * 0.06,
                    color: Theme.of(context).primaryColor ?? Colors.blue, // Fallback color
                    fontFamily: 'ComicNeue',
                  ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(
              "Welcome, $userName",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: Theme.of(context).primaryColor ?? Colors.blue,
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
                    color: Theme.of(context).primaryColor ?? Colors.blue,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: screenWidth * 0.025,
                      height: screenWidth * 0.025,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
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
          // Decorative paw prints
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            child: Row(
              children: List.generate(4, (index) => Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.15),
                child: Icon(
                  Icons.pets,
                  size: screenWidth * 0.05,
                  color: (Theme.of(context).primaryColor ?? Colors.blue).withOpacity(0.2),
                ),
              )),
            ),
          ),
          // Main content with vertical scrolling
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  // Search bar for filtering providers
                  SearchBarWidget(
                    controller: _searchController,
                    onSearchChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Services section
                  ServicesSectionWidget(services: services),
                  SizedBox(height: screenHeight * 0.03),
                  // Filter chips for pet experts
                  FilterChipsWidget(
                    filters: filters,
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Pet experts section (horizontal, max 6 items)
                  PetExpertsListWidget(providers: filteredProviders),
                  SizedBox(height: screenHeight * 0.03),
                  // Pet products section (3-row grid, below pet experts)
                  // PetProductsListWidget(products: products),
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
    // Clean up search controller
    _searchController.dispose();
    super.dispose();
  }
}