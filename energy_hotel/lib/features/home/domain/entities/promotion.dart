import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double discountPercentage;
  final DateTime validUntil;

  const Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discountPercentage,
    required this.validUntil,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    discountPercentage,
    validUntil,
  ];
}
