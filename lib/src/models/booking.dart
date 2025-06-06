import 'package:petbuddy/src/models/services_categories.dart';

class Booking {
  final int id;
  final ServicesCategories serviceCategory;
  final DateTime dateTime;
  final String status; // e.g., "Confirmed", "Completed", "Cancelled"
  final String details; // e.g., "Grooming session with extra brushing"

  Booking({
    required this.id,
    required this.serviceCategory,
    required this.dateTime,
    required this.status,
    required this.details,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      serviceCategory: ServicesCategories.fromJson(json['service_category'] ?? {}),
      dateTime: DateTime.parse(json['date_time'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'Unknown',
      details: json['details'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_category': serviceCategory.toJson(),
      'date_time': dateTime.toIso8601String(),
      'status': status,
      'details': details,
    };
  }
}