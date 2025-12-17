import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reservation.dart';

class ReservationsNotifier extends StateNotifier<List<Reservation>> {
  ReservationsNotifier() : super([]);

  void addReservation(Reservation reservation) {
    state = [reservation, ...state];
  }

  void cancelReservation(String id) {
    state = state.map((r) {
      if (r.id == id) {
        return Reservation(
          id: r.id,
          name: r.name,
          imageUrl: r.imageUrl,
          type: r.type,
          status: ReservationStatus.cancelled,
          date: r.date,
          time: r.time,
          guestCount: r.guestCount,
          price: r.price,
          category: r.category,
        );
      }
      return r;
    }).toList();
  }

  void clearAll() {
    state = [];
  }
}

final reservationsProvider =
    StateNotifierProvider<ReservationsNotifier, List<Reservation>>((ref) {
      return ReservationsNotifier();
    });

final upcomingReservationsProvider = Provider<List<Reservation>>((ref) {
  final reservations = ref.watch(reservationsProvider);
  return reservations
      .where((r) => r.status == ReservationStatus.upcoming)
      .toList();
});

final pastReservationsProvider = Provider<List<Reservation>>((ref) {
  final reservations = ref.watch(reservationsProvider);
  return reservations
      .where((r) => r.status != ReservationStatus.upcoming)
      .toList();
});
