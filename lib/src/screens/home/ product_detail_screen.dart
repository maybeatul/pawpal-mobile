import 'package:flutter/material.dart';

/// Screen displaying detailed information about a selected pet product.
class ProductDetailScreen extends StatelessWidget {
  /// The product to display.
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          product['name'],
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.05,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
            size: screenWidth * 0.06,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image placeholder
              Center(
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
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
                    radius: screenWidth * 0.2,
                    backgroundColor: const Color(0xFFFFF3F6),
                    child: Icon(
                      product['icon'],
                      size: screenWidth * 0.2,
                      color: const Color(0xFFFF80AB),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Product name
              Text(
                product['name'],
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.06,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Product category
              Text(
                product['category'],
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[700],
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Product price
              Text(
                "\$${product['price'].toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Product description
              Text(
                product['description'] ?? 'No description available.',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[800],
                  fontFamily: 'ComicNeue',
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Add to cart button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Added ${product['name']} to cart")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.white,
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
  }
}