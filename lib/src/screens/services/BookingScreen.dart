import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String serviceTitle;
  final IconData serviceIcon;
  final String serviceSvg;

  const BookingScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceIcon,
    required this.serviceSvg,
  });

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _petNameController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _petNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.grey[600]!,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.grey[600]!,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          'Book ${widget.serviceTitle}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: screenWidth * 0.06,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Left-align column
            children: [
              // Header
              SizedBox(height: screenHeight * 0.03),
              Center( // Center the SVG image
                child: Container(
                  width: screenWidth * 0.45,
                  height: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: SvgPicture.asset(
                    widget.serviceSvg,
                    height: screenWidth * 0.4,
                    width: screenWidth * 0.4,
                    fit: BoxFit.contain,
                  ).animate().fadeIn(
                        duration: 400.ms,
                        delay: 200.ms,
                      ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Book a ${widget.serviceTitle} session for your furry friend!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[600],
                      fontFamily: 'ComicNeue',
                    ),
                textAlign: TextAlign.left, // Left-align text
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 300.ms,
                  ),
              SizedBox(height: screenHeight * 0.04),
              // Pet Name Field
              Text(
                'Pet Name',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.left,
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 400.ms,
                  ),
              SizedBox(height: screenHeight * 0.01),
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: TextField(
                    controller: _petNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your pet’s name',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[400],
                            fontFamily: 'ComicNeue',
                          ),
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 500.ms,
                  ),
              SizedBox(height: screenHeight * 0.03),
              // Date Picker
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.left,
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 600.ms,
                  ),
              SizedBox(height: screenHeight * 0.01),
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01,
                  ),
                  leading: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                    size: screenWidth * 0.05,
                  ),
                  title: Text(
                    _selectedDate == null
                        ? 'Choose a date'
                        : DateFormat('MMMM d, yyyy').format(_selectedDate!),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.035,
                          color: _selectedDate == null
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () => _pickDate(context),
                ),
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 700.ms,
                  ),
              SizedBox(height: screenHeight * 0.03),
              // Time Picker
              Text(
                'Select Time',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.left,
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 800.ms,
                  ),
              SizedBox(height: screenHeight * 0.01),
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01,
                  ),
                  leading: Icon(
                    Icons.access_time,
                    color: Theme.of(context).primaryColor,
                    size: screenWidth * 0.05,
                  ),
                  title: Text(
                    _selectedTime == null
                        ? 'Choose a time'
                        : _selectedTime!.format(context),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.035,
                          color: _selectedTime == null
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () => _pickTime(context),
                ),
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 900.ms,
                  ),
              SizedBox(height: screenHeight * 0.03),
              // Notes Field
              Text(
                'Additional Notes',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'ComicNeue',
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.left,
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 1000.ms,
                  ),
              SizedBox(height: screenHeight * 0.01),
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: TextField(
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Any special requests for your pet?',
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[400],
                            fontFamily: 'ComicNeue',
                          ),
                      border: InputBorder.none,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                          fontFamily: 'ComicNeue',
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 1100.ms,
                  ),
              SizedBox(height: screenHeight * 0.04),
              // Confirm Button
              ElevatedButton(
                onPressed: () {
                  if (_petNameController.text.isEmpty ||
                      _selectedDate == null ||
                      _selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please enter pet name, date, and time.',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontFamily: 'ComicNeue',
                                color: Colors.white,
                              ),
                        ),
                        backgroundColor: Colors.red[400],
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.pets,
                            size: screenWidth * 0.05,
                            color: Colors.white,
                          ).animate().scale(
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1.0, 1.0),
                                duration: 300.ms,
                              ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: Text(
                              'Booking confirmed for ${widget.serviceTitle}! 🐾',
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontFamily: 'ComicNeue',
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft, // Left-align button content
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.04,
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
                          'Confirm Booking',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white,
                                fontFamily: 'ComicNeue',
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(
                    duration: 400.ms,
                    delay: 1200.ms,
                  ),
              SizedBox(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}