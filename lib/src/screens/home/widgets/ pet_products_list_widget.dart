import 'package:flutter/material.dart';
import 'package:petbuddy/src/screens/home/product_detail_screen.dart';
import 'package:petbuddy/src/screens/home/pet_products_screen.dart';
import 'package:petbuddy/theme.dart';
// Import the theme file containing PetAppThemeExtension

/// A horizontal scrollable grid widget displaying pet products using the app's theme.
/// Shows 3 rows with 2 fully visible cards per row and part of a third card.
class PetProductsListWidget extends StatelessWidget {
  /// List of pet products to display.
  final List<Map<String, dynamic>> products;

  /// Maximum number of products to show (default: 20).
  final int maxItems;

  const PetProductsListWidget({
    super.key,
    required this.products,
    this.maxItems = 20,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // Access the custom theme extension
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;
    // Limit to maxItems or available products
    final displayedProducts = products.take(maxItems).toList();

    // Fixed height for the grid section
    final gridHeight = screenHeight * 0.55;
    // Card height per row
    final cardHeight = gridHeight / 3;
    // Card width to show 2 cards + ~30% of a third
    final cardWidth = screenWidth / 2.3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title and See More button using theme colors
        Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.02),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                petTheme.backgroundCircle1,
                petTheme.backgroundCircle2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.pets,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    "Pet Products",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.055,
                          color: Theme.of(context).primaryColor,
                          letterSpacing: 1.5,
                        ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetProductsScreen(products: products),
                    ),
                  );
                },
                child: Text(
                  "See More",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: screenWidth * 0.045,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).primaryColor.withOpacity(0.4),
                        decorationThickness: 2,
                      ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        // Horizontal scrollable grid of product cards
        Container(
          height: gridHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayedProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 rows
              mainAxisSpacing: screenHeight * 0.02,
              crossAxisSpacing: screenWidth * 0.03,
              childAspectRatio: cardWidth / cardHeight,
            ),
            itemBuilder: (context, index) {
              final product = displayedProducts[index];
              return Transform(
                transform: Matrix4.rotationZ(index % 2 == 0 ? -0.02 : 0.02),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
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
                              // Product image placeholder
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
                              // Product name
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
                              // Product category
                              Text(
                                product['category'],
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: screenWidth * 0.03,
                                      fontStyle: FontStyle.italic,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              // Product price
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
                          // Add to Cart button
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
      ],
    );
  }
}