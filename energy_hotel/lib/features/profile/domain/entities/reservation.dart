import 'package:equatable/equatable.dart';

enum ReservationType { service, place, promotion }

enum ReservationStatus { upcoming, completed, cancelled }

class Reservation extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final ReservationType type;
  final ReservationStatus status;
  final DateTime date;
  final String time;
  final int guestCount;
  final double? price;
  final String? category;

  const Reservation({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.status,
    required this.date,
    required this.time,
    required this.guestCount,
    this.price,
    this.category,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    type,
    status,
    date,
    time,
    guestCount,
    price,
    category,
  ];
}
