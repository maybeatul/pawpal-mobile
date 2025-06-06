import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/booking.dart';
import '../../models/services_categories.dart';
import 'BookingDetailsScreen.dart';


class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Booking> _allBookings = [];
  List<Booking> _upcomingBookings = [];
  List<Booking> _historyBookings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchBookings(); // Fetch bookings when the screen loads
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _fetchBookings() {
    // Dummy data for demonstration
    // In a real app, fetch this data from an API or local storage
    final now = DateTime.now();
    final List<Booking> bookings = [
      Booking(
        id: 1,
        serviceCategory: ServicesCategories(
          id: 1,
          name: 'Grooming',
          description: 'Pet grooming services',
          iconUrl: 'https://example.com/icons/grooming.png',
          serviceCount: 5,
        ),
        dateTime: now.add(const Duration(days: 2)),
        status: 'Confirmed',
        details: 'Full grooming session with bath and nail trimming',
      ),
      Booking(
        id: 2,
        serviceCategory: ServicesCategories(
          id: 2,
          name: 'Training',
          description: 'Pet training sessions',
          iconUrl: 'https://example.com/icons/training.png',
          serviceCount: 3,
        ),
        dateTime: now.subtract(const Duration(days: 1)),
        status: 'Completed',
        details: 'Basic obedience training session',
      ),
      Booking(
        id: 3,
        serviceCategory: ServicesCategories(
          id: 1,
          name: 'Grooming',
          description: 'Pet grooming services',
          iconUrl: 'https://example.com/icons/grooming.png',
          serviceCount: 5,
        ),
        dateTime: now.add(const Duration(days: 5)),
        status: 'Confirmed',
        details: 'Express grooming with fur brushing',
      ),
      Booking(
        id: 4,
        serviceCategory: ServicesCategories(
          id: 3,
          name: 'Veterinary',
          description: 'Veterinary checkups',
          iconUrl: 'https://example.com/icons/vet.png',
          serviceCount: 2,
        ),
        dateTime: now.subtract(const Duration(days: 10)),
        status: 'Completed',
        details: 'Annual checkup and vaccination',
      ),
    ];

    setState(() {
      _allBookings = bookings;
      _upcomingBookings = bookings.where((booking) => booking.dateTime.isAfter(now)).toList();
      _historyBookings = bookings.where((booking) => booking.dateTime.isBefore(now)).toList();
    });

    // Real API call example (uncomment to use):
    /*
    final response = await http.get(
      Uri.parse('https://your-api-endpoint/bookings'),
      headers: {'Authorization': 'Bearer your_token'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _allBookings = data.map((json) => Booking.fromJson(json)).toList();
        _upcomingBookings = _allBookings.where((booking) => booking.dateTime.isAfter(now)).toList();
        _historyBookings = _allBookings.where((booking) => booking.dateTime.isBefore(now)).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load bookings: ${response.statusCode}')),
      );
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF6C00), // Using primary color from PetAppTheme
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: const Color(0xFFE6F0FA), // Light blue from PetAppTheme
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFEF6C00),
          unselectedLabelColor: Colors.grey[600],
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
          indicatorColor: const Color(0xFFEF6C00),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingsList(_upcomingBookings, screenWidth, screenHeight),
          _buildBookingsList(_historyBookings, screenWidth, screenHeight),
        ],
      ),
    );
  }

Widget _buildBookingsList(List<Booking> bookings, double screenWidth, double screenHeight) {
  if (bookings.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 60,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No bookings found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontFamily: 'Poppins',
                ),
          ),
        ],
      ),
    );
  }

  return ListView.builder(
    padding: EdgeInsets.symmetric(
      vertical: screenHeight * 0.02,
      horizontal: screenWidth * 0.05,
    ),
    itemCount: bookings.length,
    itemBuilder: (context, index) {
      final booking = bookings[index];
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingDetailsScreen(booking: booking),
            ),
          );
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    booking.serviceCategory.iconUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.pets,
                          color: Colors.grey,
                          size: 30,
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
                        booking.serviceCategory.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: 18,
                              color: const Color(0xFFEF6C00),
                              fontFamily: 'Poppins',
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM dd, yyyy – hh:mm a').format(booking.dateTime),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontFamily: 'Poppins',
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.details,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: 'Poppins',
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(booking.status),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
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