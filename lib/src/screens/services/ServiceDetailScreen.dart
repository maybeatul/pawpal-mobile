import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy/src/screens/services/BookingScreen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceTitle;
  final IconData serviceIcon;
  final String serviceSvg;

  const ServiceDetailScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceIcon,
    required this.serviceSvg,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Sample data for info cards, reviews, and FAQs
    final List<Map<String, String>> infoCards = [
      {
        'title': 'What’s the Fun?',
        'description': 'Snuggly $serviceTitle with lots of love! 🐾',
        'icon': 'assets/icons/pet_happy.svg', // Replace with cute pet icon
      },
      {
        'title': 'How Long?',
        'description': 'A quick 1-2 hour pet party! 🐶',
        'icon': 'assets/icons/pet_play.svg', // Replace with cute pet icon
      },
      {
        'title': 'Get Ready!',
        'description': 'Bring a toy for happy vibes! ✨',
        'icon': 'assets/icons/pet_toy.svg', // Replace with cute pet icon
      },
    ];

    final List<Map<String, dynamic>> reviews = [
      {
        'user': 'Luna & Me',
        'rating': 4.9,
        'comment': 'Luna’s sparkling and so happy! 🐕💖',
        'date': 'May 12, 2025',
        'avatar': 'assets/avatars/puppy.png', // Replace with chibi pet avatar
      },
      {
        'user': 'Milo & Family',
        'rating': 4.6,
        'comment': 'Super fun, but a tiny wait. 😺',
        'date': 'May 8, 2025',
        'avatar': 'assets/avatars/kitten.png', // Replace with chibi pet avatar
      },
    ];

    final List<Map<String, String>> faqs = [
      {
        'question': 'What’s in $serviceTitle?',
        'answer': 'Cuddles, care, and happy pet vibes! 🐾',
      },
      {
        'question': 'Can I stay with my buddy?',
        'answer': 'Pros handle the fun; you relax in our lounge! 😸',
      },
      {
        'question': 'How often should we visit?',
        'answer': 'Every 4-6 weeks for more fun! 🐶',
      },
    ];

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          serviceTitle,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.06,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).primaryColor,
              size: screenWidth * 0.06,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$serviceTitle is your pet’s favorite! 🐾')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Left-align column
                children: [
                  // Service Header
                  SizedBox(height: screenHeight * 0.03),
                  Center( // Center the SVG image
                    child: Container(
                      width: screenWidth * 0.45,
                      height: screenWidth * 0.45,
                      child: SvgPicture.asset(
                        serviceSvg,
                        height: screenWidth * 0.4,
                        width: screenWidth * 0.4,
                        fit: BoxFit.contain,
                      ).animate().scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1.0, 1.0),
                            duration: 800.ms,
                            curve: Curves.bounceOut,
                          ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'A cuddly $serviceTitle adventure for your furry friend!',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                    textAlign: TextAlign.left, // Left-align text
                  ).animate().fadeIn(delay: 400.ms),
                  SizedBox(height: screenHeight * 0.04),
                  // Scrollable Info Cards
                  Text(
                    '$serviceTitle Facts',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.05,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.left, // Left-align text
                  ).animate().fadeIn(delay: 600.ms),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: infoCards.length,
                      itemBuilder: (context, index) {
                        final card = infoCards[index];
                        final List<Color> cardColors = [
                          const Color(0xFFFFD1DC), // Bubblegum pink
                          const Color(0xFFB3E5FC), // Baby blue
                          const Color(0xFFFFF9C4), // Creamy yellow
                        ];
                        return Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.04),
                          child: Container(
                            width: screenWidth * 0.45,
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            decoration: BoxDecoration(
                              color: cardColors[index % cardColors.length],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  card['icon']!, // Replace with actual icon
                                  height: screenWidth * 0.06,
                                  width: screenWidth * 0.06,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start, // Left-align column
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        card['title']!,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.035,
                                              color: Theme.of(context).primaryColor,
                                              fontFamily: 'ComicNeue',
                                              fontWeight: FontWeight.bold,
                                            ),
                                        textAlign: TextAlign.left, // Left-align text
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Text(
                                        card['description']!,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.03,
                                              color: Colors.grey[600],
                                              fontFamily: 'ComicNeue',
                                            ),
                                        textAlign: TextAlign.left, // Left-align text
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: (800 + index * 200).ms).scale(
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1.0, 1.0),
                                duration: 600.ms,
                                curve: Curves.bounceOut,
                              ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Reviews Section
                  Text(
                    'Reviews & Ratings',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.05,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.left, // Left-align text
                  ).animate().fadeIn(delay: 1000.ms),
                  SizedBox(height: screenHeight * 0.02),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: screenWidth * 0.06,
                                backgroundImage: AssetImage(review['avatar']), // Replace with chibi pet avatar
                                backgroundColor: const Color(0xFFFFF9C4),
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Left-align column
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          review['user'],
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                fontSize: screenWidth * 0.04,
                                                color: Theme.of(context).primaryColor,
                                                fontFamily: 'ComicNeue',
                                                fontWeight: FontWeight.bold,
                                              ),
                                          textAlign: TextAlign.left, // Left-align text
                                        ),
                                        Row(
                                          children: List.generate(5, (starIndex) {
                                            return Icon(
                                              starIndex < review['rating'].floor()
                                                  ? Icons.star_rounded
                                                  : Icons.star_border_rounded,
                                              size: screenWidth * 0.04,
                                              color: const Color(0xFFFFB300),
                                            ).animate().scale(
                                                  begin: const Offset(0.8, 0.8),
                                                  end: const Offset(1.0, 1.0),
                                                  duration: 400.ms,
                                                  delay: (starIndex * 100).ms,
                                                );
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Container(
                                      padding: EdgeInsets.all(screenWidth * 0.03),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        review['comment'],
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.grey[600],
                                              fontFamily: 'ComicNeue',
                                            ),
                                        textAlign: TextAlign.left, // Left-align text
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      review['date'],
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.grey[500],
                                            fontFamily: 'ComicNeue',
                                          ),
                                      textAlign: TextAlign.left, // Left-align text
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: (1200 + index * 200).ms).slideY(
                              begin: 0.2,
                              end: 0,
                              duration: 600.ms,
                              curve: Curves.bounceOut,
                            ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // FAQ Section
                  Text(
                    'FAQs 🐾',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.05,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.left, // Left-align text
                  ).animate().fadeIn(delay: 1600.ms),
                  SizedBox(height: screenHeight * 0.02),
                 ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: faqs.length,
  itemBuilder: (context, index) {
    final faq = faqs[index];
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: ExpansionTile(
          leading: Icon(
            Icons.pets,
            size: screenWidth * 0.05,
            color: Theme.of(context).primaryColor,
          ).animate().fadeIn(
                duration: 400.ms,
                delay: (200 + index * 100).ms,
              ),
          title: Text(
            faq['question']!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: screenWidth * 0.04,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'ComicNeue',
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.left, // Left-align text
          ),
          iconColor: Theme.of(context).primaryColor,
          collapsedIconColor: Theme.of(context).primaryColor.withOpacity(0.4),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.04,
                screenWidth * 0.02,
                screenWidth * 0.04,
                screenWidth * 0.04,
              ),
              child: Text(
                faq['answer']!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                      fontFamily: 'ComicNeue',
                    ),
                textAlign: TextAlign.left, // Left-align text
              ),
            ),
          ],
        ),
      ).animate().fadeIn(
            duration: 400.ms,
            delay: (300 + index * 100).ms,
          ),
    );
  },
),
                  
                  SizedBox(height: screenHeight * 0.15), // Space for floating button
                ],
              ),
            ),
          ),
          // Floating Book Appointment Button
          Positioned(
            bottom: screenHeight * 0.03,
            left: screenWidth * 0.06, // Align with left padding
            right: screenWidth * 0.06,
            child: ElevatedButton(
              onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingScreen(
        serviceTitle: serviceTitle,
        serviceIcon: serviceIcon,
        serviceSvg: serviceSvg,
      ),
    ),
  );
},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 6,
                backgroundColor: Colors.transparent,
                shadowColor: Theme.of(context).primaryColor.withOpacity(0.4),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Container(
                  alignment: Alignment.centerLeft, // Left-align button content
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.06,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.pets,
                        size: screenWidth * 0.05,
                        color: Colors.white,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Book Cuddle Time!',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white,
                              fontFamily: 'ComicNeue',
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.left, // Left-align text
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 600.ms).scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.bounceOut,
                ),
          ),
        ],
      ),
    );
  }
}

class SpeechBubbleTailPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  SpeechBubbleTailPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width * 0.5, size.height, size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}