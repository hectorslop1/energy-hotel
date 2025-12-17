import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/chip_filter.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../domain/entities/place.dart';
import '../providers/explore_provider.dart';
import '../widgets/place_card.dart';
import 'place_detail_screen.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  void _navigateToPlaceDetail(BuildContext context, Place place) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PlaceDetailScreen(place: place, heroTag: 'place_${place.id}'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: AppDurations.pageTransition,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final placesAsync = ref.watch(filteredPlacesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(
              child: _buildCategoryFilters(ref, selectedCategory),
            ),
            SliverPadding(
              padding: AppSpacing.screenPadding,
              sliver: placesAsync.when(
                data: (places) => _buildPlacesGrid(places),
                loading: () => _buildLoadingGrid(),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Center(child: Text('Error loading places')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          const Text('Explore', style: AppTextStyles.displaySmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Discover amazing places nearby',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.textTertiary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Search places...',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(WidgetRef ref, PlaceCategory? selectedCategory) {
    final categories = [
      (null, 'All', Icons.apps),
      (PlaceCategory.restaurants, 'Restaurants', Icons.restaurant),
      (PlaceCategory.activities, 'Activities', Icons.directions_run),
      (PlaceCategory.attractions, 'Attractions', Icons.photo_camera),
      (PlaceCategory.shopping, 'Shopping', Icons.shopping_bag),
      (PlaceCategory.nightlife, 'Nightlife', Icons.nightlife),
    ];

    return SizedBox(
      height: 50,
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
                ref.read(selectedCategoryProvider.notifier).state = category;
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlacesGrid(List<Place> places) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: AppDurations.normal + Duration(milliseconds: index * 50),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: PlaceCard(
            place: places[index],
            heroTag: 'place_${places[index].id}',
            onTap: () => _navigateToPlaceDetail(context, places[index]),
          ),
        );
      }, childCount: places.length),
    );
  }

  Widget _buildLoadingGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => const ShimmerCard(height: 250),
        childCount: 4,
      ),
    );
  }
}
