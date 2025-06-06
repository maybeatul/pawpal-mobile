// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:lottie/lottie.dart';

// class AddPetsScreen extends StatefulWidget {
//   const AddPetsScreen({super.key});

//   @override
//   _AddPetsScreenState createState() => _AddPetsScreenState();
// }

// class _AddPetsScreenState extends State<AddPetsScreen> {
//   int _currentStep = 0;
//   String? _petType;
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _breedController = TextEditingController();
//   bool _isNameValid = true;
//   bool _isAgeValid = true;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _ageController.dispose();
//     _breedController.dispose();
//     super.dispose();
//   }

//   void _nextStep() {
//     if (_currentStep == 0 && _petType == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Please select a pet type.',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontFamily: 'ComicNeue',
//                   color: Colors.white,
//                 ) ??
//                 const TextStyle(
//                   fontFamily: 'ComicNeue',
//                   color: Colors.white,
//                 ),
//           ),
//           backgroundColor: Colors.red[400],
//         ),
//       );
//       return;
//     }
//     if (_currentStep == 1) {
//       setState(() {
//         _isNameValid = _nameController.text.isNotEmpty;
//         _isAgeValid = _ageController.text.isNotEmpty;
//       });
//       if (!_isNameValid || !_isAgeValid) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Please fill in required pet details.',
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontFamily: 'ComicNeue',
//                     color: Colors.white,
//                   ),
//             ),
//             backgroundColor: Colors.red[400],
//           ),
//         );
//         return;
//       }
//     }
//     setState(() {
//       if (_currentStep < 2) {
//         _currentStep++;
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Text(
//                   '${_nameController.text} the $_petType added! 🐾',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontFamily: 'ComicNeue',
//                         color: Colors.white,
//                       ),
//                 ),
//                 Lottie.asset(
//                   'assets/animations/paw_sparkle.json',
//                   width: MediaQuery.of(context).size.width,
//                   height: 60,
//                   fit: BoxFit.cover,
//                 )
//               ],
//             ),
//             backgroundColor: Theme.of(context).primaryColor,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//         Navigator.pop(context, {
//           'name': _nameController.text,
//           'type': _petType,
//           'svg': _petType == 'Cat' ? 'assets/illustrations/cat.svg' : 'assets/illustrations/dog.svg',
//         });
//       }
//     });
//   }

//   void _previousStep() {
//     setState(() {
//       if (_currentStep > 0) {
//         _currentStep--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       // resizeToAvoidBottomInset: false, // Prevents resizing when keyboard appears
//       appBar: AppBar(
//          leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: Theme.of(context).primaryColor,
//           onPressed: () {
//             Navigator.pop(context); // Navigate back to the previous screen
//           },
//         ),
//         title: Text(
//           'Add a Pet',
//           style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                 fontSize: screenWidth * 0.05,
//                 color: Theme.of(context).primaryColor,
//                 fontFamily: 'ComicNeue',
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//       ),
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Column(
//         children: [
//           // Header
//           Padding(
//             padding: EdgeInsets.only(
//               top: screenHeight * 0.05,
//               left: screenWidth * 0.05,
//               right: screenWidth * 0.05,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Add a Pet',
//                   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         fontSize: screenWidth * 0.06,
//                         color: Theme.of(context).primaryColor,
//                         fontFamily: 'ComicNeue',
//                         fontWeight: FontWeight.bold,
//                       ),
//                   textAlign: TextAlign.left,
//                 ).animate().fadeIn(
//                       duration: 300.ms,
//                     ),
//                 SizedBox(height: screenHeight * 0.01),
//                 Text(
//                   'Step ${_currentStep + 1}/3',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontSize: screenWidth * 0.04,
//                         color: Colors.grey[600],
//                         fontFamily: 'ComicNeue',
//                       ),
//                   textAlign: TextAlign.left,
//                 ).animate().fadeIn(
//                       duration: 300.ms,
//                       delay: 100.ms,
//                     ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Center(
//                   child: SvgPicture.asset(
//                     _petType == null
//                         ? 'assets/illustrations/pet_placeholder.svg'
//                         : _petType == 'Cat'
//                             ? 'assets/illustrations/cat.svg'
//                             : 'assets/illustrations/dog.svg',
//                     height: screenWidth * 0.15,
//                     width: screenWidth * 0.15,
//                     fit: BoxFit.contain,
//                   ).animate().scale(
//                         begin: const Offset(0.9, 0.9),
//                         end: const Offset(1.0, 1.0),
//                         duration: 300.ms,
//                         curve: Curves.easeInOut,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//           // Content
//           Expanded(
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: screenHeight - screenHeight * 0.25 - MediaQuery.of(context).padding.top,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: screenHeight * 0.03),
//                       if (_currentStep == 0) ...[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildPetTypeButton(
//                               context,
//                               type: 'Cat',
//                               svg: 'assets/illustrations/cat.svg',
//                               isSelected: _petType == 'Cat',
//                               screenWidth: screenWidth,
//                               screenHeight: screenHeight,
//                             ),
//                             _buildPetTypeButton(
//                               context,
//                               type: 'Dog',
//                               svg: 'assets/illustrations/dog.svg',
//                               isSelected: _petType == 'Dog',
//                               screenWidth: screenWidth,
//                               screenHeight: screenHeight,
//                             ),
//                           ],
//                         ).animate().fadeIn(
//                               duration: 300.ms,
//                               delay: 200.ms,
//                             ),
//                       ],
//                       if (_currentStep == 1) ...[
//                         _buildTextField(
//                           context,
//                           controller: _nameController,
//                           label: 'Name',
//                           hint: 'Enter pet’s name',
//                           isValid: _isNameValid,
//                           screenWidth: screenWidth,
//                           screenHeight: screenHeight,
//                         ),
//                         SizedBox(height: screenHeight * 0.03),
//                         _buildTextField(
//                           context,
//                           controller: _ageController,
//                           label: 'Age',
//                           hint: 'Enter pet’s age (years)',
//                           isValid: _isAgeValid,
//                           keyboardType: TextInputType.number,
//                           screenWidth: screenWidth,
//                           screenHeight: screenHeight,
//                         ),
//                         SizedBox(height: screenHeight * 0.03),
//                         _buildTextField(
//                           context,
//                           controller: _breedController,
//                           label: 'Breed (Optional)',
//                           hint: 'Enter pet’s breed',
//                           isValid: true,
//                           screenWidth: screenWidth,
//                           screenHeight: screenHeight,
//                         ),
//                       ].animate().fadeIn(
//                             duration: 300.ms,
//                             delay: 200.ms,
//                           ),
//                       if (_currentStep == 2) ...[
//                         Center(
//                           child: SvgPicture.asset(
//                             _petType == 'Cat' ? 'assets/illustrations/cat.svg' : 'assets/illustrations/dog.svg',
//                             height: screenWidth * 0.2,
//                             width: screenWidth * 0.2,
//                             fit: BoxFit.contain,
//                           ).animate().scale(
//                                 begin: const Offset(0.9, 0.9),
//                                 end: const Offset(1.0, 1.0),
//                                 duration: 300.ms,
//                               ),
//                         ),
//                         SizedBox(height: screenHeight * 0.03),
//                         _buildDetailRow(
//                           context,
//                           'Type',
//                           _petType ?? 'Not selected',
//                           screenWidth,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         _buildDetailRow(
//                           context,
//                           'Name',
//                           _nameController.text,
//                           screenWidth,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         _buildDetailRow(
//                           context,
//                           'Age',
//                           '${_ageController.text} years',
//                           screenWidth,
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         _buildDetailRow(
//                           context,
//                           'Breed',
//                           _breedController.text.isEmpty ? 'Not specified' : _breedController.text,
//                           screenWidth,
//                         ),
//                       ].animate().fadeIn(
//                             duration: 300.ms,
//                             delay: 200.ms,
//                           ),
//                       SizedBox(height: screenHeight * 0.04),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Bottom Navigation
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.05,
//           vertical: screenHeight * 0.02,
//         ),
//         color: Theme.of(context).scaffoldBackgroundColor,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (_currentStep > 0)
//               TextButton(
//                 onPressed: _previousStep,
//                 child: Text(
//                   'Back',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                         fontSize: screenWidth * 0.045,
//                         color: Theme.of(context).primaryColor,
//                         fontFamily: 'ComicNeue',
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ).animate().fadeIn(
//                     duration: 300.ms,
//                     delay: 300.ms,
//                   )
//             else
//               const SizedBox.shrink(),
//             TextButton(
//               onPressed: _nextStep,
//               child: Text(
//                 _currentStep == 2 ? 'Add Pet' : 'Next',
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontSize: screenWidth * 0.045,
//                       color: Theme.of(context).primaryColor,
//                       fontFamily: 'ComicNeue',
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ).animate().scale(
//                   begin: const Offset(0.95, 0.95),
//                   end: const Offset(1.0, 1.0),
//                   duration: 300.ms,
//                   delay: 300.ms,
//                 ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPetTypeButton(
//     BuildContext context, {
//     required String type,
//     required String svg,
//     required bool isSelected,
//     required double screenWidth,
//     required double screenHeight,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _petType = type;
//         });
//       },
//       child: Container(
//         width: screenWidth * 0.42,
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
//             width: 2,
//           ),
//         ),
//         child: Column(
//           children: [
//             SvgPicture.asset(
//               svg,
//               height: screenWidth * 0.15,
//               width: screenWidth * 0.15,
//               fit: BoxFit.contain,
//             ).animate().scale(
//                   begin: isSelected ? const Offset(0.9, 0.9) : const Offset(1.0, 1.0),
//                   end: isSelected ? const Offset(1.0, 1.0) : const Offset(0.9, 0.9),
//                   duration: 200.ms,
//                 ),
//             SizedBox(height: screenHeight * 0.01),
//             Text(
//               type,
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: screenWidth * 0.04,
//                     color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
//                     fontFamily: 'ComicNeue',
//                     fontWeight: FontWeight.bold,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     BuildContext context, {
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required bool isValid,
//     required double screenWidth,
//     required double screenHeight,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: screenWidth * 0.04,
//                 color: Theme.of(context).primaryColor,
//                 fontFamily: 'ComicNeue',
//                 fontWeight: FontWeight.bold,
//               ),
//           textAlign: TextAlign.left,
//         ),
//         SizedBox(height: screenHeight * 0.01),
//         TextField(
//           controller: controller,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontSize: screenWidth * 0.04,
//                   color: Colors.grey[400],
//                   fontFamily: 'ComicNeue',
//                 ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Theme.of(context).primaryColor.withOpacity(0.3),
//                 width: 1,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Theme.of(context).primaryColor.withOpacity(0.3),
//                 width: 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Theme.of(context).primaryColor,
//                 width: 2,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Colors.red[400]!,
//                 width: 2,
//               ),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Colors.red[400]!,
//                 width: 2,
//               ),
//             ),
//             errorText: isValid ? null : 'This field is required',
//             errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontSize: screenWidth * 0.035,
//                   color: Colors.red[400],
//                   fontFamily: 'ComicNeue',
//                 ),
//           ),
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: screenWidth * 0.04,
//                 color: Colors.grey[800],
//                 fontFamily: 'ComicNeue',
//               ),
//           textAlign: TextAlign.left,
//           onChanged: (value) {
//             setState(() {
//               if (label == 'Name') _isNameValid = value.isNotEmpty;
//               if (label == 'Age') _isAgeValid = value.isNotEmpty;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailRow(
//     BuildContext context,
//     String label,
//     String value,
//     double screenWidth,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$label:',
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: screenWidth * 0.04,
//                 color: Theme.of(context).primaryColor,
//                 fontFamily: 'ComicNeue',
//                 fontWeight: FontWeight.bold,
//               ),
//           textAlign: TextAlign.left,
//         ),
//         SizedBox(width: screenWidth * 0.03),
//         Expanded(
//           child: Text(
//             value,
//             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontSize: screenWidth * 0.04,
//                   color: Colors.grey[600],
//                   fontFamily: 'ComicNeue',
//                 ),
//             textAlign: TextAlign.left,
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPetsScreen extends StatefulWidget {
  const AddPetsScreen({super.key});

  @override
  _AddPetsScreenState createState() => _AddPetsScreenState();
}

class _AddPetsScreenState extends State<AddPetsScreen> {
  int _currentStep = 0;
  String? _petType;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  bool _isNameValid = true;
  bool _isAgeValid = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _breedController.dispose();
    super.dispose();
  }

  Future<void> _createPet() async {
    setState(() {
      _isLoading = true;
    });

    const String baseUrl = 'http://127.0.0.1:3000/api/v1';
    const String userId = '1'; // Should be dynamic in a real app
    final Uri url = Uri.parse('$baseUrl/users/$userId/pets');

    // Retrieve token from local storage (or use the provided one for now)
    const String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNiwiZXhwIjoxNzQ5MjYzMzcyfQ.hJAB4K-QVHerpt0xIRjyIFIWku6dValDiIffavv83X8';

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'breed': _breedController.text.isEmpty ? 'Unknown' : _breedController.text,
          'age': int.tryParse(_ageController.text) ?? 0,
          'pet_type': _petType,
          'weight': 0.0, // Default value; you can add a field to the form if needed
          'description': 'No description provided', // Default value; add a field if needed
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Success: Pet created
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Pet created successfully: $responseData');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '${_nameController.text} the $_petType added! 🐾',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'ComicNeue',
                        color: Colors.white,
                      ),
                ),
                Lottie.asset(
                  'assets/animations/paw_sparkle.json',
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            backgroundColor: Theme.of(context).primaryColor,
            duration: const Duration(seconds: 2),
          ),
        );

        // Pop the screen with the pet data (optional, if the parent needs it)
        Navigator.pop(context, {
          'name': _nameController.text,
          'type': _petType,
          'svg': _petType == 'Cat' ? 'assets/illustrations/cat.svg' : 'assets/illustrations/dog.svg',
        });
      } else {
        // Error: Handle failure
        print('Failed to create pet: ${response.statusCode} - ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to add pet: ${response.statusCode}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontFamily: 'ComicNeue',
                    color: Colors.white,
                  ),
            ),
            backgroundColor: Colors.red[400],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error creating pet: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error adding pet: $e',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontFamily: 'ComicNeue',
                  color: Colors.white,
                ),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
    }
  }

  void _nextStep() {
    if (_currentStep == 0 && _petType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a pet type.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'ComicNeue',
                  color: Colors.white,
                ) ??
                const TextStyle(
                  fontFamily: 'ComicNeue',
                  color: Colors.white,
                ),
          ),
          backgroundColor: Colors.red[400],
        ),
      );
      return;
    }
    if (_currentStep == 1) {
      setState(() {
        _isNameValid = _nameController.text.isNotEmpty;
        _isAgeValid = _ageController.text.isNotEmpty;
      });
      if (!_isNameValid || !_isAgeValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please fill in required pet details.',
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
    }
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        // Call the API to create the pet
        _createPet();
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Add a Pet',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: screenWidth * 0.05,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'ComicNeue',
                    fontWeight: FontWeight.bold,
                  ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02, // Adjusted padding
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step ${_currentStep + 1}/3',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey[600],
                            fontFamily: 'ComicNeue',
                          ),
                      textAlign: TextAlign.left,
                    ).animate().fadeIn(
                          duration: 300.ms,
                          delay: 100.ms,
                        ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: SvgPicture.asset(
                        _petType == null
                            ? 'assets/illustrations/pet_placeholder.svg'
                            : _petType == 'Cat'
                                ? 'assets/illustrations/cat.svg'
                                : 'assets/illustrations/dog.svg',
                        height: screenWidth * 0.15,
                        width: screenWidth * 0.15,
                        fit: BoxFit.contain,
                      ).animate().scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1.0, 1.0),
                            duration: 300.ms,
                            curve: Curves.easeInOut,
                          ),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: screenHeight - screenHeight * 0.25 - MediaQuery.of(context).padding.top,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          if (_currentStep == 0) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildPetTypeButton(
                                  context,
                                  type: 'Cat',
                                  svg: 'assets/illustrations/cat.svg',
                                  isSelected: _petType == 'Cat',
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                ),
                                _buildPetTypeButton(
                                  context,
                                  type: 'Dog',
                                  svg: 'assets/illustrations/dog.svg',
                                  isSelected: _petType == 'Dog',
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                ),
                              ],
                            ).animate().fadeIn(
                                  duration: 300.ms,
                                  delay: 200.ms,
                                ),
                          ],
                          if (_currentStep == 1) ...[
                            _buildTextField(
                              context,
                              controller: _nameController,
                              label: 'Name',
                              hint: 'Enter pet’s name',
                              isValid: _isNameValid,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            _buildTextField(
                              context,
                              controller: _ageController,
                              label: 'Age',
                              hint: 'Enter pet’s age (years)',
                              isValid: _isAgeValid,
                              keyboardType: TextInputType.number,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            _buildTextField(
                              context,
                              controller: _breedController,
                              label: 'Breed (Optional)',
                              hint: 'Enter pet’s breed',
                              isValid: true,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ].animate().fadeIn(
                                duration: 300.ms,
                                delay: 200.ms,
                              ),
                          if (_currentStep == 2) ...[
                            Center(
                              child: SvgPicture.asset(
                                _petType == 'Cat' ? 'assets/illustrations/cat.svg' : 'assets/illustrations/dog.svg',
                                height: screenWidth * 0.2,
                                width: screenWidth * 0.2,
                                fit: BoxFit.contain,
                              ).animate().scale(
                                    begin: const Offset(0.9, 0.9),
                                    end: const Offset(1.0, 1.0),
                                    duration: 300.ms,
                                  ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            _buildDetailRow(
                              context,
                              'Type',
                              _petType ?? 'Not selected',
                              screenWidth,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildDetailRow(
                              context,
                              'Name',
                              _nameController.text,
                              screenWidth,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildDetailRow(
                              context,
                              'Age',
                              '${_ageController.text} years',
                              screenWidth,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            _buildDetailRow(
                              context,
                              'Breed',
                              _breedController.text.isEmpty ? 'Not specified' : _breedController.text,
                              screenWidth,
                            ),
                          ].animate().fadeIn(
                                duration: 300.ms,
                                delay: 200.ms,
                              ),
                          SizedBox(height: screenHeight * 0.04),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  TextButton(
                    onPressed: _isLoading ? null : _previousStep,
                    child: Text(
                      'Back',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: screenWidth * 0.045,
                            color: _isLoading ? Colors.grey : Theme.of(context).primaryColor,
                            fontFamily: 'ComicNeue',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ).animate().fadeIn(
                        duration: 300.ms,
                        delay: 300.ms,
                      )
                else
                  const SizedBox.shrink(),
                TextButton(
                  onPressed: _isLoading ? null : _nextStep,
                  child: Text(
                    _currentStep == 2 ? 'Add Pet' : 'Next',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: screenWidth * 0.045,
                          color: _isLoading ? Colors.grey : Theme.of(context).primaryColor,
                          fontFamily: 'ComicNeue',
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ).animate().scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1.0, 1.0),
                      duration: 300.ms,
                      delay: 300.ms,
                    ),
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildPetTypeButton(
    BuildContext context, {
    required String type,
    required String svg,
    required bool isSelected,
    required double screenWidth,
    required double screenHeight,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _petType = type;
        });
      },
      child: Container(
        width: screenWidth * 0.42,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              svg,
              height: screenWidth * 0.15,
              width: screenWidth * 0.15,
              fit: BoxFit.contain,
            ).animate().scale(
                  begin: isSelected ? const Offset(0.9, 0.9) : const Offset(1.0, 1.0),
                  end: isSelected ? const Offset(1.0, 1.0) : const Offset(0.9, 0.9),
                  duration: 200.ms,
                ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              type,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: screenWidth * 0.04,
                    color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
                    fontFamily: 'ComicNeue',
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isValid,
    required double screenWidth,
    required double screenHeight,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: screenWidth * 0.04,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: screenHeight * 0.01),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[400],
                  fontFamily: 'ComicNeue',
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red[400]!,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red[400]!,
                width: 2,
              ),
            ),
            errorText: isValid ? null : 'This field is required',
            errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: screenWidth * 0.035,
                  color: Colors.red[400],
                  fontFamily: 'ComicNeue',
                ),
          ),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: screenWidth * 0.04,
                color: Colors.grey[800],
                fontFamily: 'ComicNeue',
              ),
          textAlign: TextAlign.left,
          onChanged: (value) {
            setState(() {
              if (label == 'Name') _isNameValid = value.isNotEmpty;
              if (label == 'Age') _isAgeValid = value.isNotEmpty;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    double screenWidth,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: screenWidth * 0.04,
                color: Theme.of(context).primaryColor,
                fontFamily: 'ComicNeue',
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.left,
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                  fontFamily: 'ComicNeue',
                ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}