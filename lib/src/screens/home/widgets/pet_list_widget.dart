import 'package:flutter/material.dart';
import 'package:petbuddy/src/models/pet.dart';
import 'package:petbuddy/src/screens/home/AddPetsScreen.dart';
import 'package:petbuddy/src/screens/home/pet_details_screen.dart';

class PetListWidget extends StatelessWidget {
  // Constructor to accept pet items
  final List<Pet> petItems;

  const PetListWidget({Key? key, required this.petItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Pet Items Count: ${petItems.length}');
    return SizedBox(
      height: 150, // Height of the horizontal scroll area
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Add Pet Button as the first item
            _buildAddPetCard(context),
            // Followed by the actual pet items
            ...petItems.map((item) {
              print('Pet Image URL: ${item.imageUrl}'); // Fixed log message
              return _buildPetCard(item.imageUrl, item.name ,item, context);
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Widget for the "Add Pet" card
  Widget _buildAddPetCard(BuildContext context) {
    return Container(
      width: 100, // Same width as other cards
      child: Card(
        elevation: 4, // Shadow for the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            // Define the action when "Add Pet" is tapped
            // For example, navigate to an "Add Pet" screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPetsScreen()),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Plus Icon
              Icon(
                Icons.add,
                size: 40,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              // Add Pet Label
              Text(
                'Add Pet',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for each small pet card
  Widget _buildPetCard( String imageUrl, String name, Pet pet, BuildContext context) {
    return
    GestureDetector(
      child:  Container(
      width: 100, // Width of each card
      child: Card(
        elevation: 4, // Shadow for the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pet Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.pets, size: 40); // Fallback if image fails
                },
              ),
            ),
            const SizedBox(height: 8),
            // Pet Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
      onTap: () {
        // Define the action when a pet card is tapped
        // For example, navigate to a detailed view of the pet
        print('Tapped on pet: $name'); // Debug log
        // You can add navigation logic here if needed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetDetailsScreen(pet: pet)),
        );

      }
  ,
    );
    
  }
}