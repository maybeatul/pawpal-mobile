import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petbuddy/theme.dart';


/// Screen for booking pet services with pet selection, packages, and scheduling.
class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  // Sample list of user's pets
  final List<Map<String, String>> pets = [
    {'name': 'Luna', 'type': 'Cat'},
    {'name': 'Max', 'type': 'Dog'},
    {'name': 'Bella', 'type': 'Dog'},
  ];

  // Sample service types
  final List<String> serviceTypes = ['Grooming', 'Vet Checkup', 'Training'];

  // Sample packages for different services
  final Map<String, List<Map<String, dynamic>>> servicePackages = {
    'Grooming': [
      {'name': 'Basic', 'description': 'Bath and Brush', 'charge': 25.0},
      {'name': 'Deluxe', 'description': 'Bath, Brush, Nail Trim', 'charge': 40.0},
      {'name': 'Premium', 'description': 'Full Grooming + Spa', 'charge': 60.0},
    ],
    'Vet Checkup': [
      {'name': 'Routine', 'description': 'Basic Health Check', 'charge': 30.0},
      {'name': 'Comprehensive', 'description': 'Health Check + Vaccinations', 'charge': 50.0},
    ],
    'Training': [
      {'name': 'Beginner', 'description': 'Basic Commands', 'charge': 35.0},
      {'name': 'Advanced', 'description': 'Advanced Skills', 'charge': 55.0},
    ],
  };

  // Form state
  String? _selectedPet;
  String? _selectedService;
  Map<String, dynamic>? _selectedPackage;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  // Helper to show date picker
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

  // Helper to show time picker
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

  // Helper to book the service
  void _bookService(BuildContext context) {
    if (_selectedPet == null ||
        _selectedService == null ||
        _selectedPackage == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill all required fields",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final bookingDetails = {
      'pet': _selectedPet,
      'service': _selectedService,
      'package': _selectedPackage!['name'],
      'charge': _selectedPackage!['charge'],
      'date': "${_selectedDate!.toLocal()}".split(' ')[0],
      'time': _selectedTime!.format(context),
      'notes': _notesController.text,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Booked $_selectedService for $_selectedPet on ${bookingDetails['date']} at ${bookingDetails['time']}",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 3),
      ),
    );

    setState(() {
      _selectedPet = null;
      _selectedService = null;
      _selectedPackage = null;
      _selectedDate = null;
      _selectedTime = null;
      _notesController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final petTheme = Theme.of(context).extension<PetAppThemeExtension>()!;

    // Debug prints to verify the lists
    print("Pets list: $pets");
    print("Service types: $serviceTypes");

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background paw print trail
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            child: Row(
              children: List.generate(4, (index) => Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.15),
                child: Icon(
                  Icons.pets,
                  size: screenWidth * 0.05,
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ).animate().fadeIn(delay: (800 + index * 200).ms).moveX(
                      begin: -20,
                      end: screenWidth,
                      duration: 3000.ms,
                      curve: Curves.easeInOut,
                    ),
              )),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Book a Service",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              fontSize: screenWidth * 0.07,
                            ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Icon(
                        Icons.event,
                        size: screenWidth * 0.05,
                        color: Theme.of(context).primaryColor,
                      ).animate().shake(
                            duration: 600.ms,
                            hz: 2,
                            rotation: 0.05,
                          ),
                    ],
                  ).animate().fadeIn(duration: 600.ms),
                  SizedBox(height: screenHeight * 0.03),
                  // Pet Selection Dropdown
                  Text(
                    "Select Pet",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.045,
                        ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color, // Use card color for contrast
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
                            ),
                      ),
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColor,
                      ),
                      dropdownColor: Theme.of(context).cardTheme.color, // Ensure dropdown menu is visible
                      items: pets.map((pet) {
                        return DropdownMenuItem<String>(
                          value: pet['name'],
                          child: Text(
                            "${pet['name']} (${pet['type']})",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: screenWidth * 0.04,
                                  color: Theme.of(context).textTheme.bodyMedium!.color,
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
                  ).animate().fadeIn(delay: 800.ms),
                  SizedBox(height: screenHeight * 0.03),
                  // Service Selection Dropdown
                  Text(
                    "Select Service",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.045,
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
                      value: _selectedService,
                      hint: Text(
                        "Choose a service",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey[600],
                              fontSize: screenWidth * 0.04,
                            ),
                      ),
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColor,
                      ),
                      dropdownColor: Theme.of(context).cardTheme.color,
                      items: serviceTypes.map((service) {
                        return DropdownMenuItem<String>(
                          value: service,
                          child: Text(
                            service,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: screenWidth * 0.04,
                                  color: Theme.of(context).textTheme.bodyMedium!.color,
                                ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value;
                          _selectedPackage = null;
                        });
                      },
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  SizedBox(height: screenHeight * 0.03),
                  // Package Selection
                  if (_selectedService != null) ...[
                    Text(
                      "Select Package",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontSize: screenWidth * 0.045,
                          ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    ...servicePackages[_selectedService]!.map((pkg) {
                      final isSelected = _selectedPackage == pkg;
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPackage = pkg;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : petTheme.boneColor.withOpacity(0.3),
                                width: isSelected ? 2.5 : 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).cardTheme.shadowColor ?? Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.12,
                                  height: screenWidth * 0.12,
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
                                  ),
                                  child: Icon(
                                    _selectedService == 'Grooming'
                                        ? Icons.cut
                                        : _selectedService == 'Vet Checkup'
                                            ? Icons.local_hospital
                                            : Icons.school,
                                    size: screenWidth * 0.06,
                                    color: petTheme.heartColor,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pkg['name'],
                                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                              fontSize: screenWidth * 0.045,
                                            ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Text(
                                        pkg['description'],
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontSize: screenWidth * 0.035,
                                              color: Colors.grey[600],
                                            ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Text(
                                        "\$${pkg['charge'].toStringAsFixed(2)}",
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: screenWidth * 0.038,
                                              color: petTheme.boneColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: 1200.ms).slideY(
                              begin: 0.3,
                              end: 0,
                              duration: 600.ms,
                            ),
                      );
                    }).toList(),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                  // Date and Time Selection
                  Text(
                    "Schedule",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.045,
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
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 1400.ms),
                  SizedBox(height: screenHeight * 0.03),
                  // Additional Notes
                  Text(
                    "Additional Notes",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: screenWidth * 0.045,
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
                  ).animate().fadeIn(delay: 1600.ms),
                  SizedBox(height: screenHeight * 0.03),
                  // Book Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _bookService(context),
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
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}