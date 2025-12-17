import '../../domain/entities/place.dart';
import '../../domain/repositories/explore_repository.dart';
import '../datasources/explore_mock_datasource.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  final ExploreMockDataSource _mockDataSource;

  ExploreRepositoryImpl({required ExploreMockDataSource mockDataSource})
    : _mockDataSource = mockDataSource;

  @override
  Future<List<Place>> getPlaces() async {
    return await _mockDataSource.getPlaces();
  }

  @override
  Future<List<Place>> getPlacesByCategory(PlaceCategory category) async {
    return await _mockDataSource.getPlacesByCategory(category);
  }
}
