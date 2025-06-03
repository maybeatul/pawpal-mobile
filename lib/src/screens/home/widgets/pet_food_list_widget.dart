import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/product_detail_screen.dart';
import 'package:petbuddy/src/screens/home/pet_food_screen.dart';

import 'package:petbuddy/theme.dart';

class PetFoodListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const PetFoodListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    // Filter products for Food category
    final foodProducts = products.where((product) => product['category'] == 'Food').toList();

    // Split into two rows (e.g., even and odd indices for simplicity)
    final firstRow = foodProducts.asMap().entries.where((entry) => entry.key % 2 == 0).map((entry) => entry.value).toList();
    final secondRow = foodProducts.asMap().entries.where((entry) => entry.key % 2 != 0).map((entry) => entry.value).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pet Food",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    fontFamily: 'ComicNeue',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetFoodScreen(products: products),
                  ),
                );
              },
              child: Text(
                "See More",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.035,
                      fontFamily: 'ComicNeue',
                      color: petTheme.boneColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),
        // First Row
        SizedBox(
          height: screenHeight * 0.3,
          child: firstRow.isEmpty
              ? Center(
                  child: Text(
                    "No food products available",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: firstRow.length,
                  itemBuilder: (context, index) {
                    final product = firstRow[index];
                    return _buildProductCard(context, product, screenWidth, screenHeight, petTheme);
                  },
                ),
        ),
        // SizedBox(height: screenHeight * 0.01),
        // Second Row
        SizedBox(
          height: screenHeight * 0.3,
          child: secondRow.isEmpty
              ? Center(
                  child: Text(
                    "No food products available",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: secondRow.length,
                  itemBuilder: (context, index) {
                    final product = secondRow[index];
                    return _buildProductCard(context, product, screenWidth, screenHeight, petTheme);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    Map<String, dynamic> product,
    double screenWidth,
    double screenHeight,
    PetAppThemeExtension petTheme,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product, allProducts: products),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.22,
        margin: EdgeInsets.only(right: screenWidth * 0.03, bottom: screenHeight * 0.02),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                product['image'],
                height: screenHeight * 0.15,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: screenHeight * 0.15,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Weight and Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.002,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "${product['discount']}% off",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: screenWidth * 0.026,
                                  color: petTheme.heartColor,
                                  fontFamily: 'ComicNeue',
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: screenWidth * 0.028,
                              color: Colors.amber,
                            ),
                            SizedBox(width: screenWidth * 0.005),
                            Text(
                              product['rating'].toString(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: screenWidth * 0.026,
                                    color: Colors.grey[600],
                                    fontFamily: 'ComicNeue',
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    // Product Name
                    Text(
                      product['name']?.toString() ?? 'Unknown Product',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'ComicNeue',
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    // Discount and Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹${product['price'].toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'ComicNeue',
                                    color: Theme.of(context).textTheme.bodyMedium!.color,
                                  ),
                            ),
                            SizedBox(width: screenWidth * 0.005),
                            Text(
                              "₹${product['originalPrice'].toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: screenWidth * 0.026,
                                    color: Colors.grey[600],
                                    fontFamily: 'ComicNeue',
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    // Add Button and Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Added ${product['name']} to cart")),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenHeight * 0.003,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: petTheme.boneColor, width: 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Add",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: screenWidth * 0.026,
                                    color: petTheme.boneColor,
                                    fontFamily: 'ComicNeue',
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}