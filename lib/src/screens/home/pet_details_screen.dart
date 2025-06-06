import 'package:flutter/material.dart';
import 'package:petbuddy/src/models/pet.dart';
import 'package:petbuddy/theme.dart'; // Assuming this is where PetAppTheme is defined

class PetDetailsScreen extends StatelessWidget {
  final Pet pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final petTheme = theme.extension<PetAppThemeExtension>()!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          pet.name,
          style: theme.textTheme.headlineMedium,
        ),
      ),
      body: Stack(
        children: [
          // Background circles for decoration
          Positioned(
            top: -screenHeight * 0.1,
            left: -screenWidth * 0.2,
            child: Container(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: petTheme.backgroundCircle1,
              ),
            ),
          ),
          Positioned(
            bottom: -screenHeight * 0.1,
            right: -screenWidth * 0.2,
            child: Container(
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: petTheme.backgroundCircle2,
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet Image
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        pet.imageUrl,
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.6,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: screenWidth * 0.6,
                            height: screenWidth * 0.6,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.pets,
                              size: screenWidth * 0.2,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Pet Name and Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet.name,
                        style: theme.textTheme.headlineMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          pet.petType,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Pet Description
                  Text(
                    pet.description,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Pet Details Card
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
                            'Details',
                            style: theme.textTheme.headlineMedium!.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildDetailRow(
                            context,
                            icon: Icons.cake,
                            label: 'Age',
                            value: pet.age != null ? '${pet.age} years' : 'Not specified',
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.pets,
                            label: 'Breed',
                            value: pet.breed.isNotEmpty ? pet.breed : 'Not specified',
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.fitness_center,
                            label: 'Weight',
                            value: pet.weight.isNotEmpty ? pet.weight : 'Not specified',
                          ),
                          _buildDetailRow(
                            context,
                            icon: Icons.male,
                            label: 'Gender',
                            value: pet.gender.isNotEmpty ? pet.gender : 'Not specified',
                          ),
                          // _buildDetailRow(
                          //   context,
                          //   icon: Icons.check_circle,
                          //   label: 'Status',
                          //   value: pet.isActive ? 'Active' : 'Inactive',
                          // ),
                          // _buildDetailRow(
                          //   context,
                          //   icon: Icons.calendar_today,
                          //   label: 'Created',
                          //   value: pet.createdAt.toLocal().toString().split('.')[0],
                          // ),
                          // if (pet.updatedAt != null)
                          //   _buildDetailRow(
                          //     context,
                          //     icon: Icons.update,
                          //     label: 'Updated',
                          //     value: pet.updatedAt!.toLocal().toString().split('.')[0],
                          //   ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context,
                        icon: Icons.favorite,
                        label: 'Favorite',
                        color: petTheme.heartColor,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${pet.name} added to favorites!',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: petTheme.heartColor,
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context,
                        icon: Icons.edit,
                        label: 'Edit',
                        color: theme.primaryColor,
                        onTap: () {
                          // Navigate to an EditPetScreen (to be implemented)
                          print('Edit ${pet.name} tapped');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, {required IconData icon, required String label, required String value}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}