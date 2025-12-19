import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/service_card.dart';
import '../widgets/promotion_card.dart';
import '../widgets/quick_action_card.dart';
import 'service_detail_screen.dart';
import '../widgets/promotion_detail_sheet.dart';
import '../widgets/quick_action_sheet.dart';
import '../widgets/spa_booking_sheet.dart';
import '../widgets/dining_booking_sheet.dart';
import '../widgets/room_service_sheet.dart';
import '../widgets/stay_info_card.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _navigateToServiceDetail(service) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ServiceDetailScreen(
              service: service,
              heroTag: 'service_${service.id}',
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: AppDurations.pageTransition,
      ),
    );
  }

  void _showPromotionDetail(promotion) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PromotionDetailSheet(promotion: promotion),
    );
  }

  void _showQuickActionSheet(String title, IconData icon) {
    Widget sheet;

    switch (title) {
      case 'Spa':
        sheet = const SpaBookingSheet();
        break;
      case 'Dining':
        sheet = const DiningBookingSheet();
        break;
      case 'Room Service':
        sheet = const RoomServiceSheet();
        break;
      default:
        sheet = QuickActionSheet(title: title, icon: icon);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => sheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;
    final userName = authState.user?.name.split(' ').first ?? l10n.guest;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(featuredServicesProvider);
            ref.invalidate(promotionsProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(userName)),
              SliverToBoxAdapter(child: _buildStayInfo()),
              SliverToBoxAdapter(child: _buildQuickActions()),
              SliverToBoxAdapter(child: _buildPromotionsSection()),
              SliverToBoxAdapter(child: _buildFeaturedServicesSection()),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String userName) {
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.hello}, $userName',
                    style: AppTextStyles.displaySmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    AppLocalizations.of(context)!.welcomeToHotel,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildNotificationBell(),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        userName[0].toUpperCase(),
                        style: AppTextStyles.headlineMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBell() {
    final unreadCount = ref.watch(unreadCountProvider);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NotificationsScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: AppColors.textPrimary,
              size: 24,
            ),
            if (unreadCount > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    unreadCount > 9 ? '9+' : unreadCount.toString(),
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showExtendStaySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExtendStaySheet(
        currentCheckOut: DateTime.now().add(const Duration(days: 3)),
        pricePerNight: 299.0,
        onConfirm: () {
          // Refresh data if needed
        },
      ),
    );
  }

  Widget _buildStayInfo() {
    // Simulated stay data - in a real app this would come from a provider
    final checkInDate = DateTime.now().subtract(const Duration(days: 2));
    final checkOutDate = DateTime.now().add(const Duration(days: 3));

    return StayInfoCard(
      checkInDate: checkInDate,
      checkOutDate: checkOutDate,
      roomNumber: '412',
      roomType: 'Ocean View Suite',
      onExtendStay: _showExtendStaySheet,
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: SectionHeader(
              title: AppLocalizations.of(context)!.quickActions,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: QuickActionCard(
                  icon: Icons.spa_outlined,
                  label: AppLocalizations.of(context)!.spa,
                  onTap: () => _showQuickActionSheet('Spa', Icons.spa_outlined),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: QuickActionCard(
                  icon: Icons.restaurant_outlined,
                  label: AppLocalizations.of(context)!.dining,
                  onTap: () => _showQuickActionSheet(
                    'Dining',
                    Icons.restaurant_outlined,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: QuickActionCard(
                  icon: Icons.pool_outlined,
                  label: AppLocalizations.of(context)!.pool,
                  onTap: () =>
                      _showQuickActionSheet('Pool', Icons.pool_outlined),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: QuickActionCard(
                  icon: Icons.room_service_outlined,
                  label: AppLocalizations.of(context)!.roomService,
                  onTap: () => _showQuickActionSheet(
                    'Room Service',
                    Icons.room_service_outlined,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsSection() {
    final promotionsAsync = ref.watch(promotionsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: SectionHeader(
              title: AppLocalizations.of(context)!.promotions,
              actionText: AppLocalizations.of(context)!.seeAll,
              onActionTap: () {},
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 180,
            child: promotionsAsync.when(
              data: (promotions) => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: promotions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < promotions.length - 1 ? AppSpacing.md : 0,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration:
                            AppDurations.normal +
                            Duration(milliseconds: index * 100),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(20 * (1 - value), 0),
                              child: child,
                            ),
                          );
                        },
                        child: PromotionCard(
                          promotion: promotions[index],
                          onTap: () => _showPromotionDetail(promotions[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
              loading: () => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.md),
                    child: ShimmerCard(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 180,
                    ),
                  );
                },
              ),
              error: (error, stack) => Center(
                child: Text(
                  AppLocalizations.of(context)!.errorLoadingPromotions,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedServicesSection() {
    final servicesAsync = ref.watch(featuredServicesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: SectionHeader(
              title: AppLocalizations.of(context)!.featuredServices,
              actionText: AppLocalizations.of(context)!.seeAll,
              onActionTap: () {},
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 220,
            child: servicesAsync.when(
              data: (services) => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index < services.length - 1 ? AppSpacing.md : 0,
                    ),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration:
                          AppDurations.normal +
                          Duration(milliseconds: index * 100),
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
                      child: ServiceCard(
                        service: services[index],
                        heroTag: 'service_${services[index].id}',
                        onTap: () => _navigateToServiceDetail(services[index]),
                      ),
                    ),
                  );
                },
              ),
              loading: () => ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.md),
                    child: ShimmerCard(width: 200, height: 220),
                  );
                },
              ),
              error: (error, stack) => Center(
                child: Text(AppLocalizations.of(context)!.errorLoadingServices),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
