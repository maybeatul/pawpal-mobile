
import 'package:flutter/src/widgets/framework.dart';

class ServicesCategories {
  int id ; 
  String name;
  String description;
  String iconUrl;
  int serviceCount;

  ServicesCategories({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.serviceCount,
  });

factory ServicesCategories.fromJson(Map<String, dynamic> json) {
  return ServicesCategories(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    iconUrl: json['icon_url'] ?? '',
    serviceCount: json['services_count'] ?? 0,
  );
}

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon_url': iconUrl,
      'services_count': serviceCount,
    };
  }
}
