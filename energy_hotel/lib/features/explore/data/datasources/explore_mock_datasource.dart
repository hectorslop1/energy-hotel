import '../../domain/entities/place.dart';

abstract class ExploreMockDataSource {
  Future<List<Place>> getPlaces();
  Future<List<Place>> getPlacesByCategory(PlaceCategory category);
}

class ExploreMockDataSourceImpl implements ExploreMockDataSource {
  static const List<Place> _mockPlaces = [
    Place(
      id: '1',
      name: 'La Habichuela Sunset',
      description:
          'Upscale Mexican-Caribbean cuisine in a romantic garden setting',
      imageUrl:
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      category: PlaceCategory.restaurants,
      latitude: 20.6550,
      longitude: -87.0800,
      rating: 4.8,
      price: 85.0,
      address: 'Blvd. Kukulcan Km 12.5',
    ),
    Place(
      id: '2',
      name: 'Cenote Ik Kil',
      description: 'Stunning natural swimming hole surrounded by jungle vines',
      imageUrl:
          'https://images.unsplash.com/photo-1552074284-5e88ef1aef18?w=800',
      category: PlaceCategory.attractions,
      latitude: 20.6600,
      longitude: -87.0750,
      rating: 4.9,
      price: 25.0,
      address: 'Carretera Merida-Valladolid',
    ),
    Place(
      id: '3',
      name: 'Scuba Diving Adventure',
      description: 'Explore the second largest coral reef in the world',
      imageUrl:
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
      category: PlaceCategory.activities,
      latitude: 20.6520,
      longitude: -87.0820,
      rating: 4.7,
      price: 120.0,
      address: 'Marina Cancun',
    ),
    Place(
      id: '4',
      name: 'Luxury Avenue',
      description: 'Premium shopping mall with designer boutiques',
      imageUrl:
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800',
      category: PlaceCategory.shopping,
      latitude: 20.6540,
      longitude: -87.0790,
      rating: 4.5,
      address: 'Blvd. Kukulcan Km 13',
    ),
    Place(
      id: '5',
      name: 'Coco Bongo',
      description: 'World-famous nightclub with incredible shows',
      imageUrl:
          'https://images.unsplash.com/photo-1566737236500-c8ac43014a67?w=800',
      category: PlaceCategory.nightlife,
      latitude: 20.6560,
      longitude: -87.0810,
      rating: 4.6,
      price: 80.0,
      address: 'Blvd. Kukulcan Km 9.5',
    ),
    Place(
      id: '6',
      name: 'Puerto Madero',
      description: 'Elegant steakhouse with ocean views',
      imageUrl:
          'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c?w=800',
      category: PlaceCategory.restaurants,
      latitude: 20.6530,
      longitude: -87.0795,
      rating: 4.7,
      price: 95.0,
      address: 'Blvd. Kukulcan Km 14.1',
    ),
    Place(
      id: '7',
      name: 'Chichen Itza Tour',
      description: 'Visit one of the New Seven Wonders of the World',
      imageUrl:
          'https://images.unsplash.com/photo-1518638150340-f706e86654de?w=800',
      category: PlaceCategory.activities,
      latitude: 20.6830,
      longitude: -88.5686,
      rating: 4.9,
      price: 150.0,
      address: 'Yucatan Peninsula',
    ),
    Place(
      id: '8',
      name: 'Xcaret Park',
      description: 'Eco-archaeological park with underground rivers',
      imageUrl:
          'https://images.unsplash.com/photo-1589394815804-964ed0be2eb5?w=800',
      category: PlaceCategory.attractions,
      latitude: 20.5808,
      longitude: -87.1180,
      rating: 4.8,
      price: 130.0,
      address: 'Carretera Chetumal-Puerto Juarez',
    ),
  ];

  @override
  Future<List<Place>> getPlaces() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPlaces;
  }

  @override
  Future<List<Place>> getPlacesByCategory(PlaceCategory category) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockPlaces.where((place) => place.category == category).toList();
  }
}
