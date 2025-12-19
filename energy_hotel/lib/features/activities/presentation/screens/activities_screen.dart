import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../profile/domain/entities/reservation.dart';
import '../../../profile/presentation/providers/reservations_provider.dart';

class ActivitiesScreen extends ConsumerStatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  ConsumerState<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends ConsumerState<ActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategory = 0;

  List<String> get _categories {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.all, l10n.events, l10n.tours, l10n.classes, l10n.sports];
  }

  final List<Map<String, dynamic>> _activities = [
    {
      'id': 'a1',
      'name': 'Live Jazz Night',
      'description': 'Enjoy smooth jazz by the pool with cocktails',
      'category': 'Events',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '7:00 PM',
      'duration': '3 hours',
      'location': 'Pool Terrace',
      'price': 0.0,
      'image':
          'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?w=400',
      'spots': 50,
      'spotsLeft': 23,
    },
    {
      'id': 'a2',
      'name': 'Sunrise Yoga',
      'description': 'Start your day with beachfront yoga session',
      'category': 'Classes',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '6:30 AM',
      'duration': '1 hour',
      'location': 'Beach',
      'price': 25.0,
      'image':
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      'spots': 20,
      'spotsLeft': 8,
    },
    {
      'id': 'a3',
      'name': 'Snorkeling Adventure',
      'description': 'Explore coral reefs with expert guides',
      'category': 'Tours',
      'date': DateTime.now().add(const Duration(days: 2)),
      'time': '9:00 AM',
      'duration': '4 hours',
      'location': 'Marina',
      'price': 85.0,
      'image':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      'spots': 12,
      'spotsLeft': 4,
    },
    {
      'id': 'a4',
      'name': 'Cooking Class',
      'description': 'Learn to make authentic Mexican cuisine',
      'category': 'Classes',
      'date': DateTime.now().add(const Duration(days: 2)),
      'time': '4:00 PM',
      'duration': '2 hours',
      'location': 'El Jardín Kitchen',
      'price': 65.0,
      'image':
          'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=400',
      'spots': 10,
      'spotsLeft': 3,
    },
    {
      'id': 'a5',
      'name': 'Golf Tournament',
      'description': 'Weekly guest tournament with prizes',
      'category': 'Sports',
      'date': DateTime.now().add(const Duration(days: 3)),
      'time': '8:00 AM',
      'duration': '5 hours',
      'location': 'Ocean Golf Club',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1535131749006-b7f58c99034b?w=400',
      'spots': 24,
      'spotsLeft': 12,
    },
    {
      'id': 'a6',
      'name': 'Wine Tasting',
      'description': 'Sample premium wines from around the world',
      'category': 'Events',
      'date': DateTime.now().add(const Duration(days: 3)),
      'time': '6:00 PM',
      'duration': '2 hours',
      'location': 'Wine Cellar',
      'price': 75.0,
      'image':
          'https://images.unsplash.com/photo-1510812431401-41d2bd2722f3?w=400',
      'spots': 16,
      'spotsLeft': 6,
    },
    {
      'id': 'a7',
      'name': 'Sunset Catamaran Cruise',
      'description': 'Sail into the sunset with champagne',
      'category': 'Tours',
      'date': DateTime.now().add(const Duration(days: 4)),
      'time': '5:00 PM',
      'duration': '3 hours',
      'location': 'Marina',
      'price': 120.0,
      'image':
          'https://images.unsplash.com/photo-1500514966906-fe245eea9344?w=400',
      'spots': 30,
      'spotsLeft': 15,
    },
    {
      'id': 'a8',
      'name': 'Tennis Clinic',
      'description': 'Improve your game with pro instructors',
      'category': 'Sports',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '10:00 AM',
      'duration': '1.5 hours',
      'location': 'Tennis Courts',
      'price': 45.0,
      'image':
          'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=400',
      'spots': 8,
      'spotsLeft': 5,
    },
    {
      'id': 'a9',
      'name': 'Movie Night Under Stars',
      'description': 'Classic films on the beach with popcorn',
      'category': 'Events',
      'date': DateTime.now().add(const Duration(days: 2)),
      'time': '8:30 PM',
      'duration': '2.5 hours',
      'location': 'Beach',
      'price': 0.0,
      'image':
          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400',
      'spots': 100,
      'spotsLeft': 67,
    },
    {
      'id': 'a10',
      'name': 'Scuba Diving Intro',
      'description': 'Beginner-friendly dive experience',
      'category': 'Tours',
      'date': DateTime.now().add(const Duration(days: 5)),
      'time': '9:00 AM',
      'duration': '4 hours',
      'location': 'Dive Center',
      'price': 150.0,
      'image':
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400',
      'spots': 6,
      'spotsLeft': 2,
    },
  ];

  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedCategory == 0) return _activities;
    final category = _categories[_selectedCategory];
    return _activities.where((a) => a['category'] == category).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                AppLocalizations.of(context)!.activities,
                style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.primary.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            _buildCategoryFilter(),
            Expanded(
              child: _filteredActivities.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      itemCount: _filteredActivities.length,
                      itemBuilder: (context, index) {
                        return _buildActivityCard(_filteredActivities[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: AnimatedContainer(
              duration: AppDurations.fast,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 64, color: AppColors.textTertiary),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No activities found',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final spotsLeft = activity['spotsLeft'] as int;
    final isAlmostFull = spotsLeft <= 5;

    return GestureDetector(
      onTap: () => _showActivityDetail(activity),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryWithOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.borderRadius),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: activity['image'] as String,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(activity['category'] as String),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(
                      activity['category'] as String,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (isAlmostFull)
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.borderRadiusXl,
                        ),
                      ),
                      child: Text(
                        'Only $spotsLeft left!',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['name'] as String,
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity['description'] as String,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        Formatters.date(
                          activity['date'] as DateTime,
                          format: 'EEE, MMM dd',
                        ),
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activity['time'] as String,
                        style: AppTextStyles.caption,
                      ),
                      const Spacer(),
                      Text(
                        (activity['price'] as double) == 0
                            ? 'FREE'
                            : Formatters.currency(activity['price'] as double),
                        style: AppTextStyles.titleSmall.copyWith(
                          color: (activity['price'] as double) == 0
                              ? AppColors.success
                              : AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Events':
        return Colors.purple;
      case 'Tours':
        return Colors.blue;
      case 'Classes':
        return Colors.orange;
      case 'Sports':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  void _showActivityDetail(Map<String, dynamic> activity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ActivityDetailSheet(activity: activity),
    );
  }
}

class _ActivityDetailSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic> activity;

  const _ActivityDetailSheet({required this.activity});

  @override
  ConsumerState<_ActivityDetailSheet> createState() =>
      _ActivityDetailSheetState();
}

class _ActivityDetailSheetState extends ConsumerState<_ActivityDetailSheet> {
  int _guestCount = 1;
  bool _isProcessing = false;

  double get _totalPrice => (widget.activity['price'] as double) * _guestCount;

  Future<void> _bookActivity() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    final reservation = Reservation(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: widget.activity['name'] as String,
      imageUrl: widget.activity['image'] as String,
      type: ReservationType.service,
      status: ReservationStatus.upcoming,
      date: widget.activity['date'] as DateTime,
      time: widget.activity['time'] as String,
      guestCount: _guestCount,
      price: _totalPrice,
      category: 'Activity',
    );
    ref.read(reservationsProvider.notifier).addReservation(reservation);

    if (mounted) {
      Navigator.of(context).pop();
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.celebration,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppLocalizations.of(context)!.bookingConfirmed,
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Get ready for ${widget.activity['name']}!',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: AppLocalizations.of(context)!.done,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    final spotsLeft = activity['spotsLeft'] as int;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.borderRadiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppSpacing.borderRadiusXl),
                ),
                child: CachedNetworkImage(
                  imageUrl: activity['image'] as String,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: AppSpacing.md,
                left: AppSpacing.md,
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Positioned(
                top: AppSpacing.md,
                right: AppSpacing.md,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['name'] as String,
                    style: AppTextStyles.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    activity['description'] as String,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Date',
                    Formatters.date(
                      activity['date'] as DateTime,
                      format: 'EEEE, MMM dd',
                    ),
                  ),
                  _buildInfoRow(
                    Icons.access_time,
                    'Time',
                    activity['time'] as String,
                  ),
                  _buildInfoRow(
                    Icons.timer,
                    AppLocalizations.of(context)!.duration,
                    activity['duration'] as String,
                  ),
                  _buildInfoRow(
                    Icons.location_on,
                    AppLocalizations.of(context)!.location,
                    activity['location'] as String,
                  ),
                  _buildInfoRow(
                    Icons.people,
                    'Availability',
                    '$spotsLeft spots left',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    AppLocalizations.of(context)!.guests,
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _guestCount > 1
                            ? () => setState(() => _guestCount--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: _guestCount > 1
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                      Text('$_guestCount', style: AppTextStyles.headlineSmall),
                      IconButton(
                        onPressed: _guestCount < spotsLeft
                            ? () => setState(() => _guestCount++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                        color: _guestCount < spotsLeft
                            ? AppColors.primary
                            : AppColors.textTertiary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.total,
                          style: AppTextStyles.caption,
                        ),
                        Text(
                          _totalPrice == 0
                              ? 'FREE'
                              : Formatters.currency(_totalPrice),
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: _totalPrice == 0
                                ? AppColors.success
                                : AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      text: _isProcessing
                          ? AppLocalizations.of(context)!.processing
                          : AppLocalizations.of(context)!.bookNow,
                      isLoading: _isProcessing,
                      onPressed: _isProcessing ? null : _bookActivity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textTertiary),
          const SizedBox(width: AppSpacing.sm),
          Text('$label: ', style: AppTextStyles.bodySmall),
          Expanded(child: Text(value, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }
}
