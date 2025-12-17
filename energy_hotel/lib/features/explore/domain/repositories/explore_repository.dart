import '../entities/place.dart';

abstract class ExploreRepository {
  Future<List<Place>> getPlaces();
  Future<List<Place>> getPlacesByCategory(PlaceCategory category);
}
