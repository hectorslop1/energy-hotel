import '../../domain/entities/service.dart';
import '../../domain/entities/promotion.dart';

abstract class HomeMockDataSource {
  Future<List<Service>> getServices();
  Future<List<Service>> getFeaturedServices();
  Future<List<Promotion>> getPromotions();
}

class HomeMockDataSourceImpl implements HomeMockDataSource {
  @override
  Future<List<Service>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      Service(
        id: '1',
        name: 'Spa & Wellness',
        description: 'Relax and rejuvenate with our premium spa treatments',
        imageUrl:
            'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800',
        price: 150.0,
        category: 'wellness',
      ),
      Service(
        id: '2',
        name: 'Fine Dining',
        description: 'Experience world-class cuisine at our restaurant',
        imageUrl:
            'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800',
        price: 80.0,
        category: 'dining',
      ),
      Service(
        id: '3',
        name: 'Pool Access',
        description: 'Enjoy our infinity pool with ocean views',
        imageUrl:
            'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800',
        price: 0.0,
        category: 'amenities',
      ),
      Service(
        id: '4',
        name: 'Gym & Fitness',
        description: 'State-of-the-art fitness center open 24/7',
        imageUrl:
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
        price: 0.0,
        category: 'amenities',
      ),
      Service(
        id: '5',
        name: 'Room Service',
        description: 'Premium in-room dining available 24/7',
        imageUrl:
            'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
        price: 25.0,
        category: 'dining',
      ),
      Service(
        id: '6',
        name: 'Concierge',
        description: 'Personal assistance for all your needs',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
        price: 0.0,
        category: 'services',
      ),
    ];
  }

  @override
  Future<List<Service>> getFeaturedServices() async {
    final services = await getServices();
    return services.take(3).toList();
  }

  @override
  Future<List<Promotion>> getPromotions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Promotion(
        id: '1',
        title: 'Weekend Spa Special',
        description: 'Get 30% off all spa treatments this weekend',
        imageUrl:
            'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
        discountPercentage: 30,
        validUntil: DateTime.now().add(const Duration(days: 7)),
      ),
      Promotion(
        id: '2',
        title: 'Romantic Dinner Package',
        description: 'Candlelit dinner for two with complimentary wine',
        imageUrl:
            'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800',
        discountPercentage: 20,
        validUntil: DateTime.now().add(const Duration(days: 14)),
      ),
    ];
  }
}
