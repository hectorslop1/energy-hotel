import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/reservation.dart';
import '../providers/reservations_provider.dart';
import '../../../billing/presentation/screens/billing_screen.dart';
import '../../../room_key/presentation/screens/room_key_screen.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../activities/presentation/screens/activities_screen.dart';
import '../../../hotel_info/presentation/screens/hotel_info_screen.dart';
import '../../../loyalty/presentation/screens/loyalty_screen.dart';
import '../../../housekeeping/presentation/widgets/housekeeping_sheet.dart';
import '../../../transport/presentation/widgets/transport_sheet.dart';
import '../../../feedback/presentation/widgets/feedback_sheet.dart';
import '../../../settings/presentation/providers/language_provider.dart';
import '../../../settings/presentation/widgets/language_selector_sheet.dart';
import '../../../auth/presentation/providers/biometric_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.profile),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          children: [
            _buildProfileHeader(user?.name ?? l10n.guest, user?.email ?? ''),
            const SizedBox(height: AppSpacing.lg),
            _buildQuickServices(context),
            const SizedBox(height: AppSpacing.lg),
            _buildReservationsSection(context, ref),
            const SizedBox(height: AppSpacing.lg),
            _buildSettingsSection(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServices(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final services = [
      {
        'icon': Icons.vpn_key,
        'label': l10n.roomKey,
        'screen': const RoomKeyScreen(),
      },
      {
        'icon': Icons.receipt_long,
        'label': l10n.billing,
        'screen': const BillingScreen(),
      },
      {
        'icon': Icons.stars,
        'label': l10n.rewards,
        'screen': const LoyaltyScreen(),
      },
      {
        'icon': Icons.support_agent,
        'label': l10n.chat,
        'screen': const ChatScreen(),
      },
      {
        'icon': Icons.cleaning_services,
        'label': l10n.housekeeping,
        'sheet': const HousekeepingSheet(),
      },
      {
        'icon': Icons.directions_car,
        'label': l10n.transport,
        'sheet': const TransportSheet(),
      },
      {
        'icon': Icons.event,
        'label': l10n.activities,
        'screen': const ActivitiesScreen(),
      },
      {
        'icon': Icons.info_outline,
        'label': l10n.hotelInfo,
        'screen': const HotelInfoScreen(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.services, style: AppTextStyles.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 0.85,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: () {
                if (service['screen'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => service['screen'] as Widget,
                    ),
                  );
                } else if (service['sheet'] != null) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => service['sheet'] as Widget,
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWithOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        service['icon'] as IconData,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      service['label'] as String,
                      style: AppTextStyles.caption,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        // Feedback button
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const FeedbackSheet(
                serviceName: 'Your Stay',
                serviceType: 'room',
              ),
            );
          },
          child: Container(
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.rate_review, color: AppColors.accent),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.rateExperience,
                        style: AppTextStyles.titleSmall,
                      ),
                      Text(l10n.feedback, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.accent),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReservationsSection(BuildContext context, WidgetRef ref) {
    final upcomingReservations = ref.watch(upcomingReservationsProvider);
    final pastReservations = ref.watch(pastReservationsProvider);
    final hasReservations =
        upcomingReservations.isNotEmpty || pastReservations.isNotEmpty;

    return Container(
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
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.myReservations,
                  style: AppTextStyles.headlineSmall,
                ),
                if (hasReservations)
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!hasReservations)
            _buildEmptyReservations()
          else ...[
            if (upcomingReservations.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  AppLocalizations.of(context)!.upcoming,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...upcomingReservations.map(
                (r) => _buildReservationCard(context, ref, r),
              ),
            ],
            if (pastReservations.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  AppLocalizations.of(context)!.past,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...pastReservations
                  .take(2)
                  .map((r) => _buildReservationCard(context, ref, r)),
            ],
          ],
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }

  Widget _buildEmptyReservations() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.md),
          Builder(
            builder: (context) => Text(
              AppLocalizations.of(context)!.noReservations,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('', style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildReservationCard(
    BuildContext context,
    WidgetRef ref,
    Reservation reservation,
  ) {
    final isUpcoming = reservation.status == ReservationStatus.upcoming;
    final isCancelled = reservation.status == ReservationStatus.cancelled;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isCancelled
            ? AppColors.error.withValues(alpha: 0.05)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        border: isCancelled
            ? Border.all(color: AppColors.error.withValues(alpha: 0.2))
            : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            child: CachedNetworkImage(
              imageUrl: reservation.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 60,
                height: 60,
                color: AppColors.shimmerBase,
              ),
              errorWidget: (context, url, error) => Container(
                width: 60,
                height: 60,
                color: AppColors.shimmerBase,
                child: Icon(
                  _getReservationIcon(reservation.type),
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reservation.name,
                        style: AppTextStyles.titleSmall.copyWith(
                          decoration: isCancelled
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCancelled)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Cancelled',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.error,
                            fontSize: 9,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${Formatters.date(reservation.date, format: 'MMM dd')} • ${reservation.time}',
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  '${reservation.guestCount} ${reservation.guestCount == 1 ? 'guest' : 'guests'}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          if (isUpcoming)
            IconButton(
              onPressed: () => _showCancelDialog(context, ref, reservation),
              icon: const Icon(Icons.close, size: 18),
              color: AppColors.textTertiary,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  IconData _getReservationIcon(ReservationType type) {
    switch (type) {
      case ReservationType.service:
        return Icons.spa_outlined;
      case ReservationType.place:
        return Icons.place_outlined;
      case ReservationType.promotion:
        return Icons.local_offer_outlined;
    }
  }

  void _showCancelDialog(
    BuildContext context,
    WidgetRef ref,
    Reservation reservation,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.cancelReservation),
        content: Text(
          'Are you sure you want to cancel your reservation at ${reservation.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(reservationsProvider.notifier)
                  .cancelReservation(reservation.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppLocalizations.of(context)!.reservationCancelled,
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              AppLocalizations.of(context)!.cancelReservation,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String name, String email) {
    return Container(
      padding: AppSpacing.cardPadding,
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.primary,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : 'G',
              style: AppTextStyles.displaySmall.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.headlineSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  email,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
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
        children: [
          _buildSettingsTile(
            icon: Icons.language_outlined,
            title: l10n.language,
            subtitle:
                '${ref.watch(selectedLanguageProvider).flag} ${ref.watch(selectedLanguageProvider).name}',
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const LanguageSelectorSheet(),
              );
            },
          ),
          const Divider(height: 1),
          _buildBiometricTile(context, ref, l10n),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.credit_card_outlined,
            title: l10n.paymentMethods,
            subtitle: '',
            onTap: () {},
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: l10n.notifications,
            subtitle: '',
            onTap: () {},
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: l10n.helpSupport,
            subtitle: '',
            onTap: () {},
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.logout,
            title: l10n.logout,
            titleColor: AppColors.error,
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text(l10n.logout),
                  content: Text(l10n.logoutConfirm),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: Text(l10n.cancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: Text(
                        l10n.logout,
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                await ref.read(authProvider.notifier).logout();
                if (context.mounted) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: titleColor ?? AppColors.textSecondary),
      title: Text(
        title,
        style: AppTextStyles.titleMedium.copyWith(color: titleColor),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: AppTextStyles.bodySmall)
          : null,
      trailing:
          trailing ??
          (onTap != null
              ? const Icon(Icons.chevron_right, color: AppColors.textTertiary)
              : null),
      onTap: onTap,
    );
  }

  Widget _buildBiometricTile(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final biometricState = ref.watch(biometricEnabledProvider);
    final authState = ref.watch(authProvider);

    if (!biometricState.isAvailable) {
      return _buildSettingsTile(
        icon: Icons.fingerprint,
        title: l10n.biometricAuth,
        subtitle: l10n.biometricNotAvailable,
        trailing: Switch(
          value: false,
          onChanged: null,
          activeThumbColor: AppColors.primary,
        ),
      );
    }

    return _buildSettingsTile(
      icon: biometricState.isFaceId ? Icons.face : Icons.fingerprint,
      title: l10n.biometricAuth,
      subtitle: biometricState.isEnabled
          ? (biometricState.isFaceId ? 'Face ID' : 'Fingerprint')
          : l10n.enableBiometrics,
      trailing: biometricState.isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Switch(
              value: biometricState.isEnabled,
              onChanged: (value) async {
                if (value) {
                  _showEnableBiometricDialog(
                    context,
                    ref,
                    l10n,
                    authState.user?.email ?? '',
                  );
                } else {
                  await ref
                      .read(biometricEnabledProvider.notifier)
                      .disableBiometric();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.biometricDisabled),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              activeThumbColor: AppColors.primary,
            ),
    );
  }

  void _showEnableBiometricDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String email,
  ) {
    final biometricState = ref.read(biometricEnabledProvider);
    final iconData = biometricState.isFaceId ? Icons.face : Icons.fingerprint;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.enableBiometricTitle,
                style: AppTextStyles.titleLarge,
              ),
            ),
          ],
        ),
        content: Text(
          l10n.enableBiometricMessage,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.notNow),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _enableBiometric(context, ref, l10n, email);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(l10n.enable),
          ),
        ],
      ),
    );
  }

  Future<void> _enableBiometric(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String email,
  ) async {
    final passwordController = TextEditingController();

    final password = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.password),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: l10n.password,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(dialogContext, passwordController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );

    if (password != null && password.isNotEmpty && context.mounted) {
      final success = await ref
          .read(biometricEnabledProvider.notifier)
          .enableBiometric(
            email: email,
            password: password,
            localizedReason: l10n.biometricPrompt,
          );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? l10n.biometricEnabled : l10n.biometricFailed,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
