import '../../domain/entities/service.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_mock_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeMockDataSource _mockDataSource;

  HomeRepositoryImpl({required HomeMockDataSource mockDataSource})
    : _mockDataSource = mockDataSource;

  @override
  Future<List<Service>> getServices() async {
    return await _mockDataSource.getServices();
  }

  @override
  Future<List<Service>> getFeaturedServices() async {
    return await _mockDataSource.getFeaturedServices();
  }

  @override
  Future<List<Promotion>> getPromotions() async {
    return await _mockDataSource.getPromotions();
  }
}
