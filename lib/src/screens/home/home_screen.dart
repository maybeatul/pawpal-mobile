
import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/pet_products_screen.dart';
import 'package:petbuddy/src/screens/home/widgets/%20services_section_widget.dart';

import 'package:petbuddy/src/screens/home/widgets/filter_chips_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/pet_experts_list_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/pet_food_list_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/pet_toys_list_widget.dart';

import 'package:petbuddy/src/screens/services/ServiceDetailScreen.dart';
import 'package:petbuddy/theme.dart';

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

  // List of available services
  final List<Map<String, dynamic>> services = [
    {'title': 'Grooming', 'icon': Icons.cut, 'svg': 'assets/illustrations/undraw_good-doggy_4ast.svg'},
    {'title': 'Vet Care', 'icon': Icons.local_hospital, 'svg': 'assets/illustrations/undraw_dog_jfxm.svg'},
    {'title': 'Training', 'icon': Icons.school, 'svg': 'assets/illustrations/undraw_playing-fetch_x508.svg'},
    {'title': 'Pet Sitting', 'icon': Icons.pets, 'svg': 'assets/illustrations/undraw_relaxing-walk_hvua.svg'},
    {'title': 'Dog Walking', 'icon': Icons.directions_walk, 'svg': 'assets/illustrations/undraw_dog-walking_w27q.svg'},
    {'title': 'Pet Boarding', 'icon': Icons.hotel, 'svg': ''},
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

  // List of pet products
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Squeaky Ball',
      'category': 'Toys',
      'price': 5.99,
      'originalPrice': 6.49,
      'discount': 8,
      'weight': '50 gm',
      'rating': 4.5,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Durable rubber ball with a fun squeak for dogs.'
    },
    {
      'name': 'Organic Dog Food',
      'category': 'Food',
      'price': 29.99,
      'originalPrice': 32.99,
      'discount': 9,
      'weight': '1 kg',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'High-quality organic kibble for all breeds.'
    },
    {
      'name': 'Cat Scratching Post',
      'category': 'Accessories',
      'price': 19.99,
      'originalPrice': 21.99,
      'discount': 9,
      'weight': '500 gm',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Sturdy scratching post to keep cats entertained.'
    },
    {
      'name': 'Pet Grooming Brush',
      'category': 'Grooming',
      'price': 12.99,
      'originalPrice': 14.99,
      'discount': 13,
      'weight': '100 gm',
      'rating': 4.6,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Gentle brush for dogs and cats.'
    },
    {
      'name': 'Tennis Ball Launcher',
      'category': 'Toys',
      'price': 15.99,
      'originalPrice': 17.99,
      'discount': 11,
      'weight': '200 gm',
      'rating': 4.9,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Automatic launcher for fetch games.'
    },
    {
      'name': 'Grain-Free Cat Food',
      'category': 'Food',
      'price': 24.99,
      'originalPrice': 26.99,
      'discount': 7,
      'weight': '800 gm',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Nutritious wet food for cats.'
    },
    {
      'name': 'Dog Leash',
      'category': 'Accessories',
      'price': 9.99,
      'originalPrice': 11.99,
      'discount': 17,
      'weight': '150 gm',
      'rating': 4.5,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Strong nylon leash for daily walks.'
    },
    {
      'name': 'Pet Shampoo',
      'category': 'Grooming',
      'price': 8.99,
      'originalPrice': 9.99,
      'discount': 10,
      'weight': '200 ml',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Soothing shampoo for sensitive skin.'
    },
    {
      'name': 'Chew Bone',
      'category': 'Toys',
      'price': 7.99,
      'originalPrice': 8.99,
      'discount': 11,
      'weight': '120 gm',
      'rating': 4.6,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Long-lasting chew toy for dogs.'
    },
    {
      'name': 'Puppy Training Treats',
      'category': 'Food',
      'price': 6.99,
      'originalPrice': 7.99,
      'discount': 13,
      'weight': '100 gm',
      'rating': 4.9,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Small treats for training sessions.'
    },
    {
      'name': 'Cat Collar',
      'category': 'Accessories',
      'price': 4.99,
      'originalPrice': 5.99,
      'discount': 17,
      'weight': '20 gm',
      'rating': 4.4,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Adjustable collar with bell.'
    },
    {
      'name': 'Nail Clippers',
      'category': 'Grooming',
      'price': 11.99,
      'originalPrice': 13.99,
      'discount': 14,
      'weight': '80 gm',
      'rating': 4.5,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Safe clippers for pet nails.'
    },
    {
      'name': 'Plush Toy',
      'category': 'Toys',
      'price': 9.99,
      'originalPrice': 11.99,
      'discount': 17,
      'weight': '90 gm',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Soft toy for cuddly pets.'
    },
    {
      'name': 'Senior Dog Food',
      'category': 'Food',
      'price': 27.99,
      'originalPrice': 30.99,
      'discount': 10,
      'weight': '1.2 kg',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Specially formulated for older dogs.'
    },
    {
      'name': 'Pet Bed',
      'category': 'Accessories',
      'price': 39.99,
      'originalPrice': 44.99,
      'discount': 11,
      'weight': '1 kg',
      'rating': 4.9,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Cozy bed for dogs and cats.'
    },
    {
      'name': 'Flea Comb',
      'category': 'Grooming',
      'price': 6.99,
      'originalPrice': 7.99,
      'discount': 13,
      'weight': '50 gm',
      'rating': 4.6,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Fine-tooth comb for flea removal.'
    },
    {
      'name': 'Interactive Puzzle Toy',
      'category': 'Toys',
      'price': 14.99,
      'originalPrice': 16.99,
      'discount': 12,
      'weight': '300 gm',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Mental stimulation toy for dogs.'
    },
    {
      'name': 'Kitten Milk Formula',
      'category': 'Food',
      'price': 19.99,
      'originalPrice': 21.99,
      'discount': 9,
      'weight': '500 gm',
      'rating': 4.7,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Nutritional formula for young kittens.'
    },
    {
      'name': 'Dog Harness',
      'category': 'Accessories',
      'price': 17.99,
      'originalPrice': 19.99,
      'discount': 10,
      'weight': '200 gm',
      'rating': 4.6,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Comfortable harness for walks.'
    },
    {
      'name': 'Ear Cleaner',
      'category': 'Grooming',
      'price': 9.99,
      'originalPrice': 11.99,
      'discount': 17,
      'weight': '150 ml',
      'rating': 4.5,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Gentle solution for pet ear hygiene.'
    },
        {
      'name': 'Ball',
      'category': 'Toys',
      'price': 5.99,
      'originalPrice': 6.49,
      'discount': 8,
      'weight': '50 gm',
      'rating': 4.5,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'Durable rubber ball with a fun squeak for dogs.'
    },
    {
      'name': 'Organic Cat Food',
      'category': 'Food',
      'price': 29.99,
      'originalPrice': 32.99,
      'discount': 9,
      'weight': '1 kg',
      'rating': 4.8,
      'image': 'https://m.media-amazon.com/images/I/71iGPCE0igL.jpg',
      'description': 'High-quality organic kibble for all breeds.'
    },
  ];
  // Unused pets list (placeholder for future section)
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

  List<Map<String, dynamic>> get filteredSearchResults {
    final List<Map<String, dynamic>> combinedResults = [];

    for (var product in products) {
      if (product['name'].toLowerCase().contains(_searchQuery.toLowerCase())) {
        combinedResults.add({
          ...product,
          'type': 'Product',
        });
      }
    }

    for (var service in services) {
      if (service['title'].toLowerCase().contains(_searchQuery.toLowerCase())) {
        combinedResults.add({
          ...service,
          'type': 'Service',
          'name': service['title'],
        });
      }
    }

    return combinedResults;
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
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

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
                    color: Theme.of(context).primaryColor ?? Colors.blue,
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
        // actions: [
        //   // Profile Picture Icon
        //   Padding(
        //     padding: EdgeInsets.only(right: screenWidth * 0.02),
        //     child: IconButton(
        //       icon: Icon(
        //         Icons.account_circle,
        //         size: screenWidth * 0.07,
        //         color: Theme.of(context).primaryColor ?? Colors.blue,
        //       ),
        //       onPressed: () {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(
        //             content: Text("Profile clicked"),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        //   // Dropdown for Pets
        //   Padding(
        //     padding: EdgeInsets.only(right: screenWidth * 0.05),
        //     child: PopupMenuButton<String>(
        //       icon: Icon(
        //         Icons.arrow_drop_down,
        //         size: screenWidth * 0.07,
        //         color: Theme.of(context).primaryColor ?? Colors.blue,
        //       ),
        //       onSelected: (String value) {
        //         if (value == 'add_pet') {
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             const SnackBar(
        //               content: Text("Add new pet clicked"),
        //             ),
        //           );
        //         } else {
        //           ScaffoldMessenger.of(context).showSnackBar(
        //             SnackBar(
        //               content: Text("Selected pet: $value"),
        //             ),
        //           );
        //         }
        //       },
        //       itemBuilder: (BuildContext context) {
        //         return [
        //           ..._pets.map((pet) => PopupMenuItem<String>(
        //                 value: pet['name'],
        //                 child: Text(
        //                   pet['name'],
        //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //                         fontSize: screenWidth * 0.04,
        //                         fontFamily: 'ComicNeue',
        //                       ),
        //                 ),
        //               )).toList(),
        //           const PopupMenuDivider(),
        //           PopupMenuItem<String>(
        //             value: 'add_pet',
        //             child: Row(
        //               children: [
        //                 Icon(
        //                   Icons.add,
        //                   size: screenWidth * 0.05,
        //                   color: Theme.of(context).primaryColor ?? Colors.blue,
        //                 ),
        //                 SizedBox(width: screenWidth * 0.02),
        //                 Text(
        //                   'Add New Pet',
        //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //                         fontSize: screenWidth * 0.04,
        //                         fontFamily: 'ComicNeue',
        //                       ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ];
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),
              // Search Bar
              TextField(
                controller: _searchController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Search products or services...",
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[600],
                        fontFamily: 'ComicNeue',
                      ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardTheme.color ?? Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.04,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'ComicNeue',
                    ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Search Results Section (Grid View)
              if (_searchQuery.isNotEmpty) ...[
                Text(
                  "Search Results",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'ComicNeue',
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: screenHeight * 0.02),
                filteredSearchResults.isEmpty
                    ? Center(
                        child: Text(
                          "No results found",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey[600],
                                fontFamily: 'ComicNeue',
                              ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.95,
                        ),
                        itemCount: filteredSearchResults.length,
                        itemBuilder: (context, index) {
                          final item = filteredSearchResults[index];
                          final isProduct = item['type'] == 'Product';

                          return GestureDetector(
                            onTap: () {
                              if (isProduct) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Selected: ${item['name']} (${item['type']})",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Colors.white,
                                            fontFamily: 'ComicNeue',
                                          ),
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceDetailScreen(
                                      serviceTitle: item['title'],
                                      serviceIcon: item['icon'],
                                      serviceSvg: item['svg'],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color ?? Colors.white,
                                borderRadius: BorderRadius.circular(0),
                                boxShadow: [
                                  BoxShadow(
                                    color: petTheme.heartColor.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Icon(
                                        item['icon'],
                                        size: screenWidth * 0.1,
                                        color: petTheme.heartColor,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      item['name'],
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'ComicNeue',
                                            color: Theme.of(context).textTheme.bodyMedium!.color,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      isProduct
                                          ? "${item['category']} - \$${item['price'].toStringAsFixed(2)}"
                                          : item['type'],
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontSize: screenWidth * 0.035,
                                            color: Theme.of(context).textTheme.bodySmall!.color,
                                            fontFamily: 'ComicNeue',
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.03,
                                          vertical: screenHeight * 0.005,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isProduct ? petTheme.boneColor.withOpacity(0.2) : petTheme.heartColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Details",
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                fontSize: screenWidth * 0.035,
                                                color: isProduct ? petTheme.boneColor : petTheme.heartColor,
                                                fontFamily: 'ComicNeue',
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                SizedBox(height: screenHeight * 0.03),
              ],
              // Services section
              ServicesSectionWidget(services: services),
              SizedBox(height: screenHeight * 0.03),
              // Pet Food and Toys sections
              PetFoodListWidget(products: products),
              SizedBox(height: screenHeight * 0.03),
              PetToysListWidget(products: products),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}