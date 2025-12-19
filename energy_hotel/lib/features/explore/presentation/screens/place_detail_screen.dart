import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/place.dart';
import '../widgets/place_booking_sheet.dart';

class PlaceDetailScreen extends StatefulWidget {
  final Place place;
  final String heroTag;

  const PlaceDetailScreen({
    super.key,
    required this.place,
    required this.heroTag,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDurations.pageTransition,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getCategoryName(PlaceCategory category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case PlaceCategory.restaurants:
        return l10n.restaurant;
      case PlaceCategory.activities:
        return l10n.activities;
      case PlaceCategory.attractions:
        return l10n.attraction;
      case PlaceCategory.shopping:
        return l10n.shopping;
      case PlaceCategory.nightlife:
        return l10n.nightlife;
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

  void _showBookingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PlaceBookingSheet(place: widget.place),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildContent(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.surface,
      leading: Container(
        margin: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColors.primaryWithOpacity(0.1), blurRadius: 8),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryWithOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.shareLinkCopied),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryWithOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.addedToFavorites),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.heroTag,
          child: CachedNetworkImage(
            imageUrl: widget.place.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Container(color: AppColors.shimmerBase),
            errorWidget: (context, url, error) => Container(
              color: AppColors.shimmerBase,
              child: const Icon(Icons.image_not_supported, size: 48),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          _buildCategoryChip(),
          const SizedBox(height: AppSpacing.md),
          Text(widget.place.name, style: AppTextStyles.displaySmall),
          const SizedBox(height: AppSpacing.sm),
          _buildRatingRow(),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppLocalizations.of(context)!.about,
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.place.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildLocationSection(),
          const SizedBox(height: AppSpacing.lg),
          _buildHighlightsSection(),
          const SizedBox(height: AppSpacing.lg),
          _buildReviewsPreview(),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildCategoryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentWithOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getCategoryIcon(widget.place.category),
            size: 14,
            color: AppColors.accent,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            _getCategoryName(widget.place.category).toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        if (widget.place.rating != null) ...[
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: AppSpacing.xs),
          Text(
            widget.place.rating!.toStringAsFixed(1),
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '(${(widget.place.rating! * 20).toInt()} reviews)',
            style: AppTextStyles.bodySmall,
          ),
          const Spacer(),
        ],
        if (widget.place.address != null) ...[
          Icon(Icons.location_on, color: AppColors.textSecondary, size: 16),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              widget.place.address!,
              style: AppTextStyles.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLocationSection() {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                AppLocalizations.of(context)!.location,
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.place.address ?? 'Near Energy Hotel',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.shimmerBase,
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.map_outlined,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppLocalizations.of(context)!.viewOnMap,
                    style: AppTextStyles.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightsSection() {
    final highlights = _getHighlightsForCategory(widget.place.category);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.highlights,
          style: AppTextStyles.headlineSmall,
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: highlights
              .map(
                (highlight) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadiusXl,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        highlight['icon'] as IconData,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        highlight['label'] as String,
                        style: AppTextStyles.labelMedium,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getHighlightsForCategory(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurants:
        return [
          {'icon': Icons.wifi, 'label': 'Free WiFi'},
          {'icon': Icons.local_parking, 'label': 'Parking'},
          {'icon': Icons.ac_unit, 'label': 'Air Conditioning'},
          {'icon': Icons.credit_card, 'label': 'Cards Accepted'},
        ];
      case PlaceCategory.activities:
        return [
          {'icon': Icons.groups, 'label': 'Group Friendly'},
          {'icon': Icons.child_care, 'label': 'Family Friendly'},
          {'icon': Icons.camera_alt, 'label': 'Photo Spots'},
          {'icon': Icons.accessibility, 'label': 'Accessible'},
        ];
      case PlaceCategory.attractions:
        return [
          {'icon': Icons.camera_alt, 'label': 'Photo Spots'},
          {'icon': Icons.history, 'label': 'Historical'},
          {'icon': Icons.tour, 'label': 'Guided Tours'},
          {'icon': Icons.accessibility, 'label': 'Accessible'},
        ];
      case PlaceCategory.shopping:
        return [
          {'icon': Icons.credit_card, 'label': 'Cards Accepted'},
          {'icon': Icons.local_shipping, 'label': 'Delivery'},
          {'icon': Icons.card_giftcard, 'label': 'Gift Wrapping'},
          {'icon': Icons.ac_unit, 'label': 'Air Conditioning'},
        ];
      case PlaceCategory.nightlife:
        return [
          {'icon': Icons.music_note, 'label': 'Live Music'},
          {'icon': Icons.local_bar, 'label': 'Full Bar'},
          {'icon': Icons.security, 'label': 'Security'},
          {'icon': Icons.credit_card, 'label': 'Cards Accepted'},
        ];
    }
  }

  Widget _buildReviewsPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.reviews,
              style: AppTextStyles.headlineSmall,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildReviewCard(
          'Sarah M.',
          'Amazing experience! The staff was incredibly friendly and the atmosphere was perfect.',
          4.5,
          '2 days ago',
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildReviewCard(
          'John D.',
          'Great place, highly recommended for tourists. Will definitely come back!',
          5.0,
          '1 week ago',
        ),
      ],
    );
  }

  Widget _buildReviewCard(
    String name,
    String review,
    double rating,
    String date,
  ) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary,
                child: Text(
                  name[0],
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.titleSmall),
                  Text(date, style: AppTextStyles.caption),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 2),
                  Text(rating.toString(), style: AppTextStyles.labelSmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            review,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryWithOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.startingFrom,
                  style: AppTextStyles.labelMedium,
                ),
                if (widget.place.price != null)
                  Text(
                    Formatters.currency(widget.place.price!),
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.accent,
                    ),
                  )
                else
                  Text(
                    AppLocalizations.of(context)!.freeEntry,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.success,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: PrimaryButton(
                text: _getButtonText(),
                icon: _getButtonIcon(),
                onPressed: _showBookingSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getButtonText() {
    switch (widget.place.category) {
      case PlaceCategory.restaurants:
        return AppLocalizations.of(context)!.reserveTable;
      case PlaceCategory.activities:
        return AppLocalizations.of(context)!.bookActivity;
      case PlaceCategory.attractions:
        return AppLocalizations.of(context)!.getTickets;
      case PlaceCategory.shopping:
        return AppLocalizations.of(context)!.viewDetails;
      case PlaceCategory.nightlife:
        return AppLocalizations.of(context)!.reserve;
    }
  }

  IconData _getButtonIcon() {
    switch (widget.place.category) {
      case PlaceCategory.restaurants:
        return Icons.restaurant_menu;
      case PlaceCategory.activities:
        return Icons.confirmation_number;
      case PlaceCategory.attractions:
        return Icons.local_activity;
      case PlaceCategory.shopping:
        return Icons.local_offer;
      case PlaceCategory.nightlife:
        return Icons.nightlife;
    }
  }
}
