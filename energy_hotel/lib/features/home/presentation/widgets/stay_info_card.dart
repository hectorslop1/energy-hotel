import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';

class StayInfoCard extends StatelessWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String roomNumber;
  final String roomType;
  final VoidCallback? onExtendStay;

  const StayInfoCard({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomNumber,
    required this.roomType,
    this.onExtendStay,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isCheckedIn =
        now.isAfter(checkInDate) || now.isAtSameMomentAs(checkInDate);
    final daysRemaining = checkOutDate.difference(now).inDays;
    final hoursRemaining = checkOutDate.difference(now).inHours % 24;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: const Icon(Icons.hotel, color: Colors.white, size: 24),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.roomNumber} $roomNumber',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      roomType,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: isCheckedIn
                      ? AppColors.success.withValues(alpha: 0.9)
                      : AppColors.warning.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(
                    AppSpacing.borderRadiusXl,
                  ),
                ),
                child: Text(
                  isCheckedIn
                      ? AppLocalizations.of(context)!.checkIn
                      : AppLocalizations.of(context)!.upcoming,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _buildDateInfo(
                  icon: Icons.login,
                  label: AppLocalizations.of(context)!.checkIn,
                  date: checkInDate,
                  time: '3:00 PM',
                ),
              ),
              Container(height: 50, width: 1, color: Colors.white24),
              Expanded(
                child: _buildDateInfo(
                  icon: Icons.logout,
                  label: AppLocalizations.of(context)!.checkOut,
                  date: checkOutDate,
                  time: '11:00 AM',
                ),
              ),
            ],
          ),
          if (isCheckedIn && daysRemaining >= 0) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Row(
                children: [
                  Icon(
                    daysRemaining <= 1 ? Icons.warning_amber : Icons.schedule,
                    color: daysRemaining <= 1
                        ? AppColors.warning
                        : Colors.white70,
                    size: 20,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      daysRemaining == 0
                          ? 'Check-out today in $hoursRemaining hours'
                          : daysRemaining == 1
                          ? 'Check-out tomorrow'
                          : '$daysRemaining days remaining',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (onExtendStay != null)
                    GestureDetector(
                      onTap: onExtendStay,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.borderRadiusXl,
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.extendStay,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateInfo({
    required IconData icon,
    required String label,
    required DateTime date,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 16),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            Formatters.date(date, format: 'EEE, MMM dd'),
            style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
          ),
          Text(
            time,
            style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ExtendStaySheet extends StatefulWidget {
  final DateTime currentCheckOut;
  final double pricePerNight;
  final VoidCallback? onConfirm;

  const ExtendStaySheet({
    super.key,
    required this.currentCheckOut,
    required this.pricePerNight,
    this.onConfirm,
  });

  @override
  State<ExtendStaySheet> createState() => _ExtendStaySheetState();
}

class _ExtendStaySheetState extends State<ExtendStaySheet> {
  int _additionalNights = 1;
  bool _isProcessing = false;

  double get _totalPrice => widget.pricePerNight * _additionalNights;
  DateTime get _newCheckOut =>
      widget.currentCheckOut.add(Duration(days: _additionalNights));

  Future<void> _processExtension() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

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
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Stay Extended!', style: AppTextStyles.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your stay has been extended successfully.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'New check-out: ${Formatters.date(_newCheckOut, format: 'EEEE, MMM dd')}',
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.nights_stay,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            '$_additionalNights additional night${_additionalNights > 1 ? 's' : ''}',
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: 'Done',
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onConfirm?.call();
                  },
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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.borderRadiusXl),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.primaryWithOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                  ),
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Text('Extend Your Stay', style: AppTextStyles.headlineMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current check-out',
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(
                        Formatters.date(
                          widget.currentCheckOut,
                          format: 'MMM dd, yyyy',
                        ),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('New check-out', style: AppTextStyles.bodyMedium),
                      Text(
                        Formatters.date(_newCheckOut, format: 'MMM dd, yyyy'),
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Additional Nights', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _additionalNights > 1
                      ? () => setState(() => _additionalNights--)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 36,
                  color: _additionalNights > 1
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
                Container(
                  width: 80,
                  alignment: Alignment.center,
                  child: Text(
                    '$_additionalNights',
                    style: AppTextStyles.displaySmall,
                  ),
                ),
                IconButton(
                  onPressed: _additionalNights < 14
                      ? () => setState(() => _additionalNights++)
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 36,
                  color: _additionalNights < 14
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
              ],
            ),
            Text(
              '${Formatters.currency(widget.pricePerNight)} per night',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.primaryWithOpacity(0.05),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppTextStyles.titleMedium),
                  Text(
                    Formatters.currency(_totalPrice),
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              text: _isProcessing ? 'Processing...' : 'Confirm Extension',
              isLoading: _isProcessing,
              onPressed: _isProcessing ? null : _processExtension,
            ),
          ],
        ),
      ),
    );
  }
}
