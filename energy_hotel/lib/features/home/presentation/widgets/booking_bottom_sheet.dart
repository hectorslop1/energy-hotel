import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/service.dart';
import '../../../profile/domain/entities/reservation.dart';
import '../../../profile/presentation/providers/reservations_provider.dart';

class BookingBottomSheet extends ConsumerStatefulWidget {
  final Service service;

  const BookingBottomSheet({super.key, required this.service});

  @override
  ConsumerState<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends ConsumerState<BookingBottomSheet> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '10:00 AM';
  int _guestCount = 1;
  bool _isProcessing = false;
  bool _isSuccess = false;

  final List<String> _availableTimes = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  Future<void> _processBooking() async {
    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    final reservation = Reservation(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: widget.service.name,
      imageUrl: widget.service.imageUrl,
      type: ReservationType.service,
      status: ReservationStatus.upcoming,
      date: _selectedDate,
      time: _selectedTime,
      guestCount: _guestCount,
      price: widget.service.price,
      category: widget.service.category,
    );
    ref.read(reservationsProvider.notifier).addReservation(reservation);

    setState(() {
      _isProcessing = false;
      _isSuccess = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pop();
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SuccessDialog(
        service: widget.service,
        date: _selectedDate,
        time: _selectedTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.borderRadiusXl),
        ),
      ),
      child: SafeArea(
        child: AnimatedSwitcher(
          duration: AppDurations.normal,
          child: _isSuccess ? _buildSuccessState() : _buildBookingForm(),
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 64),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppLocalizations.of(context)!.bookingConfirmed,
            style: AppTextStyles.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Book ${widget.service.name}',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.lg),

          _buildDateSelector(),
          const SizedBox(height: AppSpacing.lg),

          _buildTimeSelector(),
          const SizedBox(height: AppSpacing.lg),

          _buildGuestSelector(),
          const SizedBox(height: AppSpacing.lg),

          _buildPriceSummary(),
          const SizedBox(height: AppSpacing.lg),

          PrimaryButton(
            text: _isProcessing
                ? AppLocalizations.of(context)!.processing
                : AppLocalizations.of(context)!.confirmBooking,
            isLoading: _isProcessing,
            onPressed: _isProcessing ? null : _processBooking,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.selectDate,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      surface: AppColors.surface,
                      onSurface: AppColors.textPrimary,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              setState(() => _selectedDate = date);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: AppColors.primary),
                const SizedBox(width: AppSpacing.md),
                Text(
                  Formatters.date(_selectedDate, format: 'EEEE, MMM dd, yyyy'),
                  style: AppTextStyles.bodyMedium,
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.selectTime,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _availableTimes.map((time) {
            final isSelected = time == _selectedTime;
            return GestureDetector(
              onTap: () => setState(() => _selectedTime = time),
              child: AnimatedContainer(
                duration: AppDurations.fast,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Text(
                  time,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGuestSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.guests,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _guestCount > 1
                    ? () => setState(() => _guestCount--)
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: _guestCount > 1 ? AppColors.primary : AppColors.divider,
              ),
              Text(
                '$_guestCount ${_guestCount == 1 ? 'Guest' : 'Guests'}',
                style: AppTextStyles.titleMedium,
              ),
              IconButton(
                onPressed: _guestCount < 4
                    ? () => setState(() => _guestCount++)
                    : null,
                icon: const Icon(Icons.add_circle_outline),
                color: _guestCount < 4 ? AppColors.primary : AppColors.divider,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    final subtotal = widget.service.price * _guestCount;
    final tax = subtotal * 0.1;
    final total = subtotal + tax;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', Formatters.currency(subtotal)),
          const SizedBox(height: AppSpacing.sm),
          _buildPriceRow('Tax (10%)', Formatters.currency(tax)),
          const Divider(height: AppSpacing.lg),
          _buildPriceRow(
            'Total',
            widget.service.price > 0
                ? Formatters.currency(total)
                : 'Complimentary',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal ? AppTextStyles.titleMedium : AppTextStyles.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.headlineSmall.copyWith(color: AppColors.accent)
              : AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  final Service service;
  final DateTime date;
  final String time;

  const _SuccessDialog({
    required this.service,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Text(
              AppLocalizations.of(context)!.bookingConfirmed,
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your reservation has been successfully made.',
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
                  _buildInfoRow(Icons.spa_outlined, service.name),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    Formatters.date(date, format: 'EEEE, MMM dd'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(Icons.access_time, time),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: AppLocalizations.of(context)!.done,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}
