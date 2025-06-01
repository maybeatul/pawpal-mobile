import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy/src/screens/services/payment_screen.dart';
import 'package:petbuddy/theme.dart';

class BookingModal extends StatefulWidget {
  final String serviceTitle;
  final Map<String, dynamic> package;
  final String serviceSvg;

  const BookingModal({
    super.key,
    required this.serviceTitle,
    required this.package,
    required this.serviceSvg,
  });

  @override
  _BookingModalState createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  // Sample list of user's pets
  final List<Map<String, String>> pets = [
    {'name': 'Luna', 'type': 'Cat'},
    {'name': 'Max', 'type': 'Dog'},
    {'name': 'Bella', 'type': 'Dog'},
  ];

  String? _selectedPet;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
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
              onSurface: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    return Container(
      height: screenHeight * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              // Modal Handle
              Center(
                child: Container(
                  width: screenWidth * 0.1,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Header with Service SVG
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
                "Book ${widget.serviceTitle} - ${widget.package['name']}",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Poppins',
                    ),
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Price: \$${widget.package['charge'].toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: screenWidth * 0.04,
                      color: petTheme.boneColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
              ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
              SizedBox(height: screenHeight * 0.03),
              // Pet Selection Dropdown
              Text(
                "Select Pet",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'Poppins',
                    ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: _selectedPet,
                  hint: Text(
                    "Choose a pet",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.04,
                          fontFamily: 'Poppins',
                        ),
                  ),
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).primaryColor,
                  ),
                  dropdownColor: Theme.of(context).cardTheme.color,
                  items: pets.map((pet) {
                    return DropdownMenuItem<String>(
                      value: pet['name'],
                      child: Text(
                        "${pet['name']} (${pet['type']})",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: screenWidth * 0.04,
                              color: Theme.of(context).textTheme.bodyMedium!.color,
                              fontFamily: 'Poppins',
                            ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPet = value;
                    });
                  },
                ),
              ).animate().fadeIn(delay: 400.ms),
              SizedBox(height: screenHeight * 0.03),
              // Date and Time Selection
              Text(
                "Schedule",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'Poppins',
                    ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? "Select Date"
                              : "${_selectedDate!.toLocal()}".split(' ')[0],
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: _selectedDate == null ? Colors.grey[600] : null,
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Poppins',
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickTime(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth * 0.03,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          _selectedTime == null
                              ? "Select Time"
                              : _selectedTime!.format(context),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: _selectedTime == null ? Colors.grey[600] : null,
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Poppins',
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 500.ms),
              SizedBox(height: screenHeight * 0.03),
              // Additional Notes
              Text(
                "Additional Notes",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'Poppins',
                    ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Any special requests?",
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[600],
                        fontSize: screenWidth * 0.04,
                        fontFamily: 'Poppins',
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms),
              SizedBox(height: screenHeight * 0.03),
              // Book Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedPet == null || _selectedDate == null || _selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please fill all required fields",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final bookingDetails = {
                      'pet': _selectedPet,
                      'service': widget.serviceTitle,
                      'package': widget.package['name'],
                      'charge': widget.package['charge'],
                      'date': "${_selectedDate!.toLocal()}".split(' ')[0],
                      'time': _selectedTime!.format(context),
                      'notes': _notesController.text,
                    };

                    Navigator.pop(context); // Close the modal
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          bookingDetails: bookingDetails,
                          serviceSvg: widget.serviceSvg,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Book Now",
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
      ),
    );
  }
}