import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petbuddy/theme.dart';
import 'package:flutter/services.dart'; // For SystemUiOverlayStyle

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> allProducts;

  const ProductDetailScreen({super.key, required this.product, required this.allProducts});

  // Dummy reviews data
  static final List<Map<String, dynamic>> _dummyReviews = [
    {
      'user': 'Alice Smith',
      'rating': 5,
      'comment': 'Excellent product! My dog loves this food, and it’s very nutritious.',
    },
    {
      'user': 'Bob Johnson',
      'rating': 4,
      'comment': 'Good quality, but the packaging could be improved.',
    },
    {
      'user': 'Emma Wilson',
      'rating': 3,
      'comment': 'Decent food, but my cat is picky and didn’t enjoy it much.',
    },
  ];

  // Dummy delivery steps
  static final List<Map<String, dynamic>> _deliverySteps = [
    {
      'icon': Icons.shopping_cart,
      'title': 'Order Placed',
      'description': 'Your order is confirmed and being prepared.',
    },
    {
      'icon': Icons.inventory_2,
      'title': 'Processing',
      'description': 'Your order is being packed and processed.',
    },
    {
      'icon': Icons.local_shipping,
      'title': 'Shipped',
      'description': 'Your order is on its way to you.',
    },
    {
      'icon': Icons.home,
      'title': 'Delivered',
      'description': 'Your order has been delivered to your address.',
    },
  ];

  // Dummy product images
  static final List<String> _dummyImages = [
    'assets/images/product1.jpg', // Replace with actual asset paths
    'assets/images/product2.jpg',
    'assets/images/product3.jpg',
  ];

  // Filter similar products (same category, excluding current product)
  List<Map<String, dynamic>> getSimilarProducts() {
    return allProducts
        .where((p) =>
            p['category'] == product['category'] && p['id'] != product['id'])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PetAppThemeExtension? petAppTheme = theme.extension<PetAppThemeExtension>();
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDark = theme.brightness == Brightness.dark;

    // Use dummy images if product['images'] is null or empty
    final List<String> images = product['images'] != null &&
            (product['images'] as List<dynamic>).isNotEmpty
        ? List<String>.from(product['images'])
        : _dummyImages;

    // Use dummy rating and reviews
    final double productRating = product['rating']?.toDouble() ?? 4.0;
    final List<Map<String, dynamic>> reviews = product['reviews'] != null &&
            (product['reviews'] as List<dynamic>).isNotEmpty
        ? List<Map<String, dynamic>>.from(product['reviews'])
        : _dummyReviews;

    // Gradient for buttons
    final Gradient buttonGradient = LinearGradient(
      colors: [theme.primaryColor, petAppTheme?.boneColor ?? Colors.amber],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final List<Map<String, dynamic>> similarProducts = getSimilarProducts();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          product['name'] ?? 'Product Details',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image Slider
                    _buildImageCarousel(
                      context,
                      images,
                      screenHeight,
                      screenWidth,
                      petAppTheme,
                      isDark,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Product Info Card
                    _buildProductInfo(
                      context,
                      product,
                      productRating,
                      screenWidth,
                      screenHeight,
                      petAppTheme,
                      isDark,
                    )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideY(begin: 0.2, end: 0, duration: 400.ms),
                    SizedBox(height: screenHeight * 0.03),
                    // Description
                    _buildModernSection(
                      context,
                      title: 'Description',
                      child: Text(
                        product['description'] ?? 'No description available.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: screenWidth * 0.04,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                      isDark: isDark,
                    )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(begin: 0.2, end: 0, duration: 400.ms),
                    SizedBox(height: screenHeight * 0.03),
                    // Manufacturer
                    _buildModernSection(
                      context,
                      title: 'Manufacturer',
                      child: Text(
                        product['manufacturer'] ?? 'Unknown Manufacturer',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: screenWidth * 0.04,
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                        ),
                      ),
                      isDark: isDark,
                    )
                        .animate()
                        .fadeIn(delay: 400.ms)
                        .slideY(begin: 0.2, end: 0, duration: 400.ms),
                    SizedBox(height: screenHeight * 0.03),
                    // Delivery Steps
                    _buildModernSection(
                      context,
                      title: 'Delivery Information',
                      child: Column(
                        children: _deliverySteps.asMap().entries.map((entry) {
                          final step = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: petAppTheme?.boneColor.withOpacity(0.2) ??
                                        Colors.amber.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    step['icon'] as IconData,
                                    size: screenWidth * 0.05,
                                    color: petAppTheme?.boneColor ?? Colors.amber,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        step['title'] as String,
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        step['description'] as String,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          fontSize: screenWidth * 0.035,
                                          color: isDark
                                              ? Colors.grey[400]
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      isDark: isDark,
                    )
                        .animate()
                        .fadeIn(delay: 500.ms)
                        .slideY(begin: 0.2, end: 0, duration: 400.ms),
                    SizedBox(height: screenHeight * 0.03),
                    // Reviews
                    _buildModernSection(
                      context,
                      title: 'Reviews',
                      child: Column(
                        children: reviews.asMap().entries.map((entry) {
                          final review = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                            child: Container(
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF2A3542) : Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        review['user'] ?? 'Anonymous',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(
                                          (review['rating'] as num).toInt(),
                                          (index) => Icon(
                                            Icons.star,
                                            size: screenWidth * 0.04,
                                            color: petAppTheme?.boneColor ?? Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    review['comment'] ?? 'No comment',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: screenWidth * 0.035,
                                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      isDark: isDark,
                    )
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideY(begin: 0.2, end: 0, duration: 400.ms),
                    SizedBox(height: screenHeight * 0.03),
                    // Similar Products
                    _buildModernSection(
                      context,
                      title: 'You Might Also Like',
                      child: SizedBox(
                        height: screenHeight * 0.25,
                        child: similarProducts.isEmpty
                            ? Center(
                                child: Text(
                                  'No similar products available',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: screenWidth * 0.04,
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: similarProducts.length,
                                itemBuilder: (context, index) {
                                  final similarProduct = similarProducts[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailScreen(
                                            product: similarProduct,
                                            allProducts: allProducts,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: screenWidth * 0.45,
                                      margin: EdgeInsets.only(right: screenWidth * 0.03),
                                      decoration: BoxDecoration(
                                        color: isDark ? const Color(0xFF2A3542) : Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                            child: Image.asset(
                                              similarProduct['image'] ?? _dummyImages[0],
                                              height: screenHeight * 0.12,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  Container(
                                                height: screenHeight * 0.12,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                    child: Icon(Icons.broken_image,
                                                        color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(screenWidth * 0.02),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  similarProduct['name'] ?? 'Unknown Product',
                                                  style:
                                                      theme.textTheme.bodyMedium?.copyWith(
                                                    fontSize: screenWidth * 0.035,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: screenHeight * 0.005),
                                                Text(
                                                  '₹${similarProduct['price']?.toStringAsFixed(2) ?? '0.00'}',
                                                  style:
                                                      theme.textTheme.bodyMedium?.copyWith(
                                                    fontSize: screenWidth * 0.035,
                                                    color:
                                                        petAppTheme?.heartColor ?? Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).animate().fadeIn(delay: (700 + index * 100).ms).scale(
                                      begin: const Offset(0.98, 0.98),
                                      end: const Offset(1, 1),
                                      duration: const Duration(milliseconds: 300));
                                },
                              ),
                      ),
                      isDark: isDark,
                    ).animate().fadeIn(delay: 700.ms).slideY(
                        begin: 0.2, end: 0, duration: const Duration(milliseconds: 400)),
                    SizedBox(height: screenHeight * 0.1), // Space for bottom bar
                  ],
                ),
              ),
            ),
            // Sticky Bottom Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  color: isDark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${product['name'] ?? 'product'} to cart'),
                              backgroundColor: petAppTheme?.boneColor ?? Colors.amber,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                          decoration: BoxDecoration(
                            gradient: buttonGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Add to Cart',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Proceeding to checkout for ${product['name'] ?? 'product'}'),
                              backgroundColor: petAppTheme?.boneColor ?? Colors.amber,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                          decoration: BoxDecoration(
                            gradient: buttonGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Buy Now',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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

  // Image Carousel Widget
  Widget _buildImageCarousel(
    BuildContext context,
    List<String> images,
    double screenHeight,
    double screenWidth,
    PetAppThemeExtension? petAppTheme,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A3542) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.3,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                enableInfiniteScroll: true,
              ),
              items: images.map((image) {
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Image zoom feature coming soon!'),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (petAppTheme?.boneColor ?? Colors.amber).withOpacity(
                        entry.key == 0 ? 1.0 : 0.4,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Product Info Card Widget
  Widget _buildProductInfo(
    BuildContext context,
    Map<String, dynamic> product,
    double rating,
    double screenWidth,
    double screenHeight,
    PetAppThemeExtension? petAppTheme,
    bool isDark,
  ) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDark ? const Color(0xFF2A3542) : Colors.white,
            isDark ? const Color(0xFF1E2A38) : Colors.grey[50]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['name'] ?? 'Unknown Product',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '₹${product['price']?.toStringAsFixed(2) ?? '0.00'}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: petAppTheme?.heartColor ?? Colors.red,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    '₹${product['originalPrice']?.toStringAsFixed(2) ?? '0.00'}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: screenWidth * 0.035,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: (petAppTheme?.heartColor ?? Colors.red).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${product['discount']}% OFF',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: screenWidth * 0.035,
                    color: petAppTheme?.heartColor ?? Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating.floor() ? Icons.star : Icons.star_border,
                    size: screenWidth * 0.04,
                    color: petAppTheme?.boneColor ?? Colors.amber,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                rating.toStringAsFixed(1),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Modern Section Widget
  Widget _buildModernSection(
    BuildContext context, {
    required String title,
    required Widget child,
    required bool isDark,
  }) {
    final ThemeData theme = Theme.of(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A3542) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          child,
        ],
      ),
    );
  }
}