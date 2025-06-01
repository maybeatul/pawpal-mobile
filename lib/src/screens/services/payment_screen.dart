import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy/src/screens/services/confirmation_screen.dart';
import 'package:petbuddy/theme.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> bookingDetails;
  final String serviceSvg;

  const PaymentScreen({
    super.key,
    required this.bookingDetails,
    required this.serviceSvg,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false;

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Payment",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.06,
                fontFamily: 'Poppins',
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: Container(
                width: screenWidth * 0.30,
                height: screenWidth * 0.30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: SvgPicture.asset(
                  widget.serviceSvg,
                  height: screenWidth * 0.25,
                  width: screenWidth * 0.25,
                  fit: BoxFit.contain,
                ).animate().fadeIn(duration: 400.ms),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Payment for ${widget.bookingDetails['service']} - ${widget.bookingDetails['package']}",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: screenWidth * 0.05,
                    fontFamily: 'Poppins',
                  ),
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Amount: \$${widget.bookingDetails['charge'].toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: petTheme.boneColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
            ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
            SizedBox(height: screenHeight * 0.03),
            // Simulated Payment Form
            Card(
              elevation: 2,
              color: Theme.of(context).cardTheme.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Card Number",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.04,
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "1234 5678 9012 3456",
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[400],
                              fontFamily: 'Poppins',
                            ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Expiry Date",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: screenWidth * 0.04,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "MM/YY",
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: screenWidth * 0.035,
                                        color: Colors.grey[400],
                                        fontFamily: 'Poppins',
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CVV",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: screenWidth * 0.04,
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              TextField(
                                decoration: InputDecoration(
                                  hintText: "123",
                                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: screenWidth * 0.035,
                                        color: Colors.grey[400],
                                        fontFamily: 'Poppins',
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 400.ms),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing
                    ? null
                    : () async {
                        setState(() {
                          _isProcessing = true;
                        });
                        // Simulate payment processing
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() {
                          _isProcessing = false;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationScreen(
                              bookingDetails: widget.bookingDetails,
                              serviceSvg: widget.serviceSvg,
                            ),
                          ),
                        );
                      },
                child: _isProcessing
                    ? SizedBox(
                        width: screenWidth * 0.05,
                        height: screenWidth * 0.05,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Pay Now",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
              ),
            ).animate().scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.bounceOut,
                ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}