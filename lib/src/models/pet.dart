class Pet {
  final int? id; // Make nullable to handle null values
  final String name;
  final String breed;
  final int? age; // Make nullable to handle null values
  final String weight;
  final String gender;
  final String petType;
  final String description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt; // Make nullable since it's not always provided
  final String imageUrl;

  Pet({
    this.id, // Nullable, no longer required
    required this.name,
    required this.breed,
    this.age, // Nullable, no longer required
    required this.weight,
    required this.gender,
    required this.petType,
    required this.description,
    required this.isActive,
    required this.createdAt,
    this.updatedAt, // Nullable, no longer required
    required this.imageUrl,
  });

  // Factory constructor to create a Pet object from JSON
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] as int?, // Handle null gracefully
      name: json['name'] as String? ?? '', // Fallback to empty string if null
      breed: json['breed'] as String? ?? '', // Fallback to empty string if null
      age: json['age'] as int?, // Handle null gracefully
      weight: json['weight'] as String? ?? '0.0', // Fallback to '0.0' if null
      gender: json['gender'] as String? ?? '', // Fallback to empty string if null
      petType: json['pet_type'] as String? ?? '', // Fallback to empty string if null
      description: json['description'] as String? ?? '', // Fallback to empty string if null
      isActive: json['is_active'] as bool? ?? false, // Fallback to false if null
      createdAt: DateTime.parse(json['created_at'] as String? ?? '1970-01-01T00:00:00Z'), // Fallback to epoch if null
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null, // Handle null
      imageUrl: json['image_url'] as String? ?? '', // Fallback to empty string if null
    );
  }

  // Method to convert a Pet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'age': age,
      'weight': weight,
      'gender': gender,
      'pet_type': petType,
      'description': description,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(), // Handle null
      'image_url': imageUrl,
    };
  }
}