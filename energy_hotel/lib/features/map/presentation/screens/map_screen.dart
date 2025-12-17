import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/chip_filter.dart';
import '../../../explore/domain/entities/place.dart';
import '../providers/map_provider.dart';
import '../widgets/place_bottom_sheet.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen>
    with TickerProviderStateMixin {
  late MapController _mapController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onMarkerTap(Place place) {
    ref.read(mapSelectedPlaceProvider.notifier).state = place;
    _showPlaceBottomSheet(place);
  }

  void _showPlaceBottomSheet(Place place) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PlaceBottomSheet(place: place),
    );
  }

  Color _getCategoryColor(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurants:
        return AppColors.accent;
      case PlaceCategory.activities:
        return AppColors.success;
      case PlaceCategory.attractions:
        return AppColors.info;
      case PlaceCategory.shopping:
        return AppColors.warning;
      case PlaceCategory.nightlife:
        return Colors.purple;
    }
  }

  IconData _getCategoryIcon(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurants:
        return Icons.restaurant;
      case PlaceCategory.activities:
        return Icons.directions_run;
      case PlaceCategory.attractions:
        return Icons.photo_camera;
      case PlaceCategory.shopping:
        return Icons.shopping_bag;
      case PlaceCategory.nightlife:
        return Icons.nightlife;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hotelLocation = ref.watch(hotelLocationProvider);
    final placesAsync = ref.watch(mapPlacesProvider);
    final selectedCategory = ref.watch(mapFilterCategoryProvider);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: hotelLocation,
              initialZoom: 14.0,
              minZoom: 10.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.energyhotel.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: hotelLocation,
                    width: 50,
                    height: 50,
                    child: _buildHotelMarker(),
                  ),
                  ...placesAsync.when(
                    data: (places) => places
                        .map(
                          (place) => Marker(
                            point: LatLng(place.latitude, place.longitude),
                            width: 70,
                            height: 85,
                            child: _buildPlaceMarker(place),
                          ),
                        )
                        .toList(),
                    loading: () => [],
                    error: (_, __) => [],
                  ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildCategoryFilters(selectedCategory),
              ],
            ),
          ),
          Positioned(
            right: AppSpacing.md,
            bottom: AppSpacing.xxl,
            child: _buildMapControls(hotelLocation),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryWithOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Search nearby places...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(PlaceCategory? selectedCategory) {
    final categories = [
      (null, 'All', Icons.apps),
      (PlaceCategory.restaurants, 'Food', Icons.restaurant),
      (PlaceCategory.activities, 'Activities', Icons.directions_run),
      (PlaceCategory.attractions, 'Sights', Icons.photo_camera),
      (PlaceCategory.shopping, 'Shopping', Icons.shopping_bag),
    ];

    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final (category, label, icon) = categories[index];
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: ChipFilter(
              label: label,
              icon: icon,
              isSelected: isSelected,
              onTap: () {
                ref.read(mapFilterCategoryProvider.notifier).state = category;
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildHotelMarker() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryWithOpacity(0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.hotel, color: Colors.white, size: 24),
          ),
        );
      },
    );
  }

  Widget _buildPlaceMarker(Place place) {
    final color = _getCategoryColor(place.category);
    final isSelected = ref.watch(mapSelectedPlaceProvider)?.id == place.id;

    return GestureDetector(
      onTap: () => _onMarkerTap(place),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image bubble
            AnimatedContainer(
              duration: AppDurations.fast,
              width: isSelected ? 65 : 55,
              height: isSelected ? 65 : 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isSelected ? 16 : 12),
                border: Border.all(
                  color: isSelected ? color : Colors.white,
                  width: isSelected ? 3 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: isSelected ? 0.5 : 0.3),
                    blurRadius: isSelected ? 12 : 8,
                    spreadRadius: isSelected ? 2 : 0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isSelected ? 13 : 10),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: place.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: color.withValues(alpha: 0.3),
                        child: Icon(
                          _getCategoryIcon(place.category),
                          color: color,
                          size: 20,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: color,
                        child: Icon(
                          _getCategoryIcon(place.category),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    // Category badge
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Icon(
                          _getCategoryIcon(place.category),
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                    // Rating badge
                    if (place.rating != null)
                      Positioned(
                        left: 2,
                        top: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 10,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                place.rating!.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Pointer triangle
            CustomPaint(
              size: const Size(12, 8),
              painter: _TrianglePainter(
                color: isSelected ? color : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls(LatLng hotelLocation) {
    return Column(
      children: [
        _buildControlButton(
          icon: Icons.my_location,
          onTap: () {
            _mapController.move(hotelLocation, 14.0);
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildControlButton(
          icon: Icons.add,
          onTap: () {
            final currentZoom = _mapController.camera.zoom;
            _mapController.move(_mapController.camera.center, currentZoom + 1);
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildControlButton(
          icon: Icons.remove,
          onTap: () {
            final currentZoom = _mapController.camera.zoom;
            _mapController.move(_mapController.camera.center, currentZoom - 1);
          },
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryWithOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = ui.Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
