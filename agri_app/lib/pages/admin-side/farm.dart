// lib/models/farm.dart
import 'package:cloud_firestore/cloud_firestore.dart';


class Farm {
  final String id;
  final String name;
  final String farmerId;
  final GeoPoint location;
  final String address;
  final String description;
  final List<String> bestSellerProducts;
  final double rating;
  final List<String> images;
  final bool isActive;

  Farm({
    required this.id,
    required this.name,
    required this.farmerId,
    required this.location,
    required this.address,
    required this.description,
    required this.bestSellerProducts,
    required this.rating,
    required this.images,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'farmerId': farmerId,
      'location': location,
      'address': address,
      'description': description,
      'bestSellerProducts': bestSellerProducts,
      'rating': rating,
      'images': images,
      'isActive': isActive,
    };
  }

  factory Farm.fromMap(Map<String, dynamic> map) {
    return Farm(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      farmerId: map['farmerId'] ?? '',
      location: map['location'] ?? const GeoPoint(0, 0),
      address: map['address'] ?? '',
      description: map['description'] ?? '',
      bestSellerProducts: List<String>.from(map['bestSellerProducts'] ?? []),
      rating: (map['rating'] ?? 0.0).toDouble(),
      images: List<String>.from(map['images'] ?? []),
      isActive: map['isActive'] ?? false,
    );
  }
}
