import 'package:equatable/equatable.dart';

enum PlaceCategory { restaurants, activities, attractions, shopping, nightlife }

class Place extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final PlaceCategory category;
  final double latitude;
  final double longitude;
  final double? rating;
  final double? price;
  final String? address;

  const Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.price,
    this.address,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    category,
    latitude,
    longitude,
    rating,
    price,
    address,
  ];
}
