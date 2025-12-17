import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../explore/domain/entities/place.dart';
import '../../../explore/presentation/providers/explore_provider.dart';

final hotelLocationProvider = Provider<LatLng>((ref) {
  return LatLng(AppConstants.hotelLatitude, AppConstants.hotelLongitude);
});

final mapSelectedPlaceProvider = StateProvider<Place?>((ref) => null);

final mapFilterCategoryProvider = StateProvider<PlaceCategory?>((ref) => null);

final mapPlacesProvider = FutureProvider<List<Place>>((ref) async {
  final filterCategory = ref.watch(mapFilterCategoryProvider);
  final repository = ref.watch(exploreRepositoryProvider);

  if (filterCategory == null) {
    return await repository.getPlaces();
  }
  return await repository.getPlacesByCategory(filterCategory);
});
