import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:http/http.dart' as http;
import 'package:petbuddy/theme.dart';
import 'dart:convert';

import '../../models/Review.dart';
import '../../models/booking.dart';

// Assuming these models are in separate files
// PetAppTheme

class BookingDetailsScreen extends StatefulWidget {
  final Booking booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  int _rating = 0; // Default rating
  final _reviewController = TextEditingController();
  bool _isSubmitting = false;
  bool _hasSubmittedReview = false; // Track if review is already submitted

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final review = Review(
      bookingId: widget.booking.id,
      rating: _rating,
      comment: _reviewController.text.trim(),
      submittedAt: DateTime.now(),
    );

    try {
      // Placeholder API call to submit the review
      final response = await http.post(
        Uri.parse('https://your-api-endpoint/bookings/${widget.booking.id}/reviews'),
        headers: {
          'Authorization': 'Bearer your_token', // Replace with actual token
          'Content-Type': 'application/json',
        },
        body: jsonEncode(review.toJson()),
      );

      setState(() {
        _isSubmitting = false;
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          _hasSubmittedReview = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Review submitted successfully!',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit review: ${response.statusCode}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error submitting review: $e',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final petTheme = theme.extension<PetAppThemeExtension>()!;

    final now = DateTime.now(); // Current date: June 06, 2025, 11:57 AM IST
    final isCompleted = widget.booking.status.toLowerCase() == 'completed';

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // title: Text(
            //   widget.booking.serviceCategory.name,
            //   style: theme.textTheme.headlineMedium,
            // ),
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Icon and Status
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.booking.serviceCategory.iconUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.pets,
                                color: Colors.grey,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.booking.serviceCategory.name,
                              style: theme.textTheme.headlineMedium!.copyWith(
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(widget.booking.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.booking.status,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(widget.booking.status),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Booking Details Card
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking Details',
                            style: theme.textTheme.headlineMedium!.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildDetailRow(
                            context,
                            icon: Icons.calendar_today,
                            label: 'Date & Time',
                            value: DateFormat('MMM dd, yyyy – hh:mm a').format(widget.booking.dateTime),
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.description,
                            label: 'Details',
                            value: widget.booking.details,
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.category,
                            label: 'Category Description',
                            value: widget.booking.serviceCategory.description,
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.numbers,
                            label: 'Booking ID',
                            value: widget.booking.id.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isCompleted) ...[
                    SizedBox(height: screenHeight * 0.03),
                    // Rating and Review Section
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rate Your Experience',
                              style: theme.textTheme.headlineMedium!.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            if (!_hasSubmittedReview) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < _rating ? Icons.star : Icons.star_border,
                                      color: petTheme.heartColor,
                                      size: 30,
                                    ),
                                    onPressed: _isSubmitting
                                        ? null
                                        : () {
                                            setState(() {
                                              _rating = index + 1;
                                            });
                                          },
                                  );
                                }),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              TextField(
                                controller: _reviewController,
                                maxLines: 3,
                                enabled: !_isSubmitting,
                                decoration: InputDecoration(
                                  hintText: 'Write your review here...',
                                  hintStyle: theme.textTheme.bodyMedium!.copyWith(
                                    color: Colors.grey[400],
                                    fontFamily: 'Poppins',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: theme.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ElevatedButton(
                                onPressed: _isSubmitting ? null : _submitReview,
                                style: theme.elevatedButtonTheme.style,
                                child: _isSubmitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'Submit Review',
                                        style: theme.textTheme.labelLarge,
                                      ),
                              ),
                            ] else ...[
                              Text(
                                'Thank you for your review!',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.green,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < _rating ? Icons.star : Icons.star_border,
                                    color: petTheme.heartColor,
                                    size: 20,
                                  );
                                }),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _reviewController.text,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.black54,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
        if (_isSubmitting)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, {required IconData icon, required String label, required String value}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: theme.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.black54,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}