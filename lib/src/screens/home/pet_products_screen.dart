import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/product_detail_screen.dart';
import 'package:petbuddy/src/screens/home/widgets/search_bar_widget.dart';
import 'package:petbuddy/src/screens/home/widgets/filter_chips_widget.dart';
import 'package:petbuddy/theme.dart';


/// Screen displaying a grid of pet products with search and filter options.
/// Shows 3 rows with 2 fully visible cards per row and part of a third card.
class PetProductsScreen extends StatefulWidget {
  /// List of all pet products.
  final List<Map<String, dynamic>> products;

  const PetProductsScreen({super.key, required this.products});

  @override
  _PetProductsScreenState createState() => _PetProductsScreenState();
}

class _PetProductsScreenState extends State<PetProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  // Filter options for product categories
  final List<String> filters = [
    'All',
    'Toys',
    'Food',
    'Accessories',
    'Grooming',
  ];

  /// Computed property to filter products based on search query and selected filter.
  List<Map<String, dynamic>> get filteredProducts {
    return widget.products.where((product) {
      final matchesFilter = _selectedFilter == 'All' || product['category'] == _selectedFilter;
      final matchesSearch = product['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product['category'].toLowerCase().contains(_searchQuery.toLowerCase());
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
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    final availableHeight = screenHeight * 0.65;
    final cardHeight = availableHeight / 3;
    final cardWidth = screenWidth / 2.3;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Pet Products",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              SearchBarWidget(
                controller: _searchController,
                onSearchChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              FilterChipsWidget(
                filters: filters,
                selectedFilter: _selectedFilter,
                onFilterSelected: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                height: availableHeight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: screenHeight * 0.02,
                      crossAxisSpacing: screenWidth * 0.03,
                      childAspectRatio: cardWidth / cardHeight,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Transform(
                        transform: Matrix4.rotationZ(index % 2 == 0 ? -0.02 : 0.02),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product, allProducts: [])
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: petTheme.boneColor.withOpacity(0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.025),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.13,
                                        height: screenWidth * 0.13,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              petTheme.backgroundCircle1,
                                              petTheme.backgroundCircle2,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          border: Border.all(
                                            color: petTheme.boneColor.withOpacity(0.3),
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: screenWidth * 0.065,
                                          backgroundColor: Theme.of(context).cardTheme.color,
                                          child: Icon(
                                            product['icon'],
                                            size: screenWidth * 0.07,
                                            color: petTheme.heartColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        product['name'],
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.042,
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.8,
                                            ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Text(
                                        product['category'],
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontSize: screenWidth * 0.03,
                                              fontStyle: FontStyle.italic,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        "\$${product['price'].toStringAsFixed(2)}",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.038,
                                              color: petTheme.boneColor,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Added ${product['name']} to cart 🐾",
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            backgroundColor: Theme.of(context).primaryColor,
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(screenWidth * 0.015),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardTheme.color,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: petTheme.heartColor.withOpacity(0.5),
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          size: screenWidth * 0.055,
                                          color: petTheme.heartColor,
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
              ),
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