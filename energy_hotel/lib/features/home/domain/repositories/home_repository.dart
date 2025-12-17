import '../entities/service.dart';
import '../entities/promotion.dart';

abstract class HomeRepository {
  Future<List<Service>> getServices();
  Future<List<Service>> getFeaturedServices();
  Future<List<Promotion>> getPromotions();
}
