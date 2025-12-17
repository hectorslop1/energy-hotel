import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/notification.dart';

class NotificationsNotifier extends StateNotifier<List<HotelNotification>> {
  NotificationsNotifier() : super(_mockNotifications);

  static final List<HotelNotification> _mockNotifications = [
    HotelNotification(
      id: 'n1',
      title: 'Check-out Reminder',
      message:
          'Your check-out is in 3 days. Would you like to extend your stay?',
      type: NotificationType.reminder,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: false,
    ),
    HotelNotification(
      id: 'n2',
      title: 'Spa Appointment Confirmed',
      message: 'Your Swedish Massage is confirmed for tomorrow at 10:00 AM.',
      type: NotificationType.reservation,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    HotelNotification(
      id: 'n3',
      title: '20% Off Dinner Tonight!',
      message: 'Enjoy 20% off at La Terraza restaurant. Valid today only!',
      type: NotificationType.promotion,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
    ),
    HotelNotification(
      id: 'n4',
      title: 'Welcome to Energy Hotel!',
      message:
          'We hope you enjoy your stay. Explore our services and amenities.',
      type: NotificationType.message,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
    HotelNotification(
      id: 'n5',
      title: 'Room Service Delivered',
      message: 'Your order has been delivered to Room 412.',
      type: NotificationType.alert,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    HotelNotification(
      id: 'n6',
      title: 'You earned 500 points!',
      message: 'Your recent spa booking earned you 500 loyalty points.',
      type: NotificationType.reward,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: false,
    ),
  ];

  void markAsRead(String id) {
    state = state.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
  }

  void markAllAsRead() {
    state = state.map((n) => n.copyWith(isRead: true)).toList();
  }

  void deleteNotification(String id) {
    state = state.where((n) => n.id != id).toList();
  }

  void addNotification(HotelNotification notification) {
    state = [notification, ...state];
  }

  void clearAll() {
    state = [];
  }
}

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<HotelNotification>>(
      (ref) => NotificationsNotifier(),
    );

final unreadCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider);
  return notifications.where((n) => !n.isRead).length;
});
