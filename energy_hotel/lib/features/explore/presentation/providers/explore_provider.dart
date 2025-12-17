import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/explore_mock_datasource.dart';
import '../../data/repositories/explore_repository_impl.dart';
import '../../domain/entities/place.dart';
import '../../domain/repositories/explore_repository.dart';

final exploreMockDataSourceProvider = Provider<ExploreMockDataSource>((ref) {
  return ExploreMockDataSourceImpl();
});

final exploreRepositoryProvider = Provider<ExploreRepository>((ref) {
  return ExploreRepositoryImpl(
    mockDataSource: ref.watch(exploreMockDataSourceProvider),
  );
});

final placesProvider = FutureProvider<List<Place>>((ref) async {
  final repository = ref.watch(exploreRepositoryProvider);
  return await repository.getPlaces();
});

final selectedCategoryProvider = StateProvider<PlaceCategory?>((ref) => null);

final filteredPlacesProvider = FutureProvider<List<Place>>((ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final repository = ref.watch(exploreRepositoryProvider);

  if (selectedCategory == null) {
    return await repository.getPlaces();
  }
  return await repository.getPlacesByCategory(selectedCategory);
});
