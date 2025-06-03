import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/product_detail_screen.dart';

import 'package:petbuddy/theme.dart';
import 'package:petbuddy/src/screens/services/ServiceDetailScreen.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> services;

  const SearchScreen({
    super.key,
    required this.products,
    required this.services,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredResults {
    final List<Map<String, dynamic>> combinedResults = [];

    // Add products to the results
    for (var product in widget.products) {
      if (product['name'].toLowerCase().contains(_searchQuery.toLowerCase())) {
        combinedResults.add({
          ...product,
          'type': 'Product',
        });
      }
    }

    // Add services to the results
    for (var service in widget.services) {
      if (service['title'].toLowerCase().contains(_searchQuery.toLowerCase())) {
        combinedResults.add({
          ...service,
          'type': 'Service',
          'name': service['title'], // Map 'title' to 'name' for consistency
        });
      }
    }

    return combinedResults;
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context), // Simply pop to go back
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search products or services...",
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                  fontFamily: 'ComicNeue',
                ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: screenWidth * 0.06,
            ),
            filled: true,
            fillColor: Theme.of(context).cardTheme.color ?? Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
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
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: filteredResults.isEmpty
            ? Center(
                child: Text(
                  _searchQuery.isEmpty ? "Start typing to search..." : "No results found",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[600],
                        fontFamily: 'ComicNeue',
                      ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Adjust the aspect ratio for better card height
                ),
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  final item = filteredResults[index];
                  final isProduct = item['type'] == 'Product';

                  return GestureDetector(
                    onTap: () {
                      if (isProduct) {
                        // Navigate to ProductDetailScreen for products
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductDetailScreen(
                        //       productName: item['name'],
                        //       productCategory: item['category'],
                        //       productPrice: item['price'],
                        //       productDescription: item['description'],
                        //     ),
                        //   ),
                        // );
                      } else {
                        // Navigate to ServiceDetailScreen for services
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
                            // Icon
                            Center(
                              child: Icon(
                                item['icon'],
                                size: screenWidth * 0.1,
                                color: petTheme.heartColor,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            // Details
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
                            // Type Indicator
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
                                  item['type'],
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
      ),
    );
  }
}