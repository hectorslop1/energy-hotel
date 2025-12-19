import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/place.dart';
import '../../../profile/domain/entities/reservation.dart';
import '../../../profile/presentation/providers/reservations_provider.dart';

class PlaceBookingSheet extends ConsumerStatefulWidget {
  final Place place;

  const PlaceBookingSheet({super.key, required this.place});

  @override
  ConsumerState<PlaceBookingSheet> createState() => _PlaceBookingSheetState();
}

class _PlaceBookingSheetState extends ConsumerState<PlaceBookingSheet> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '12:00 PM';
  int _guestCount = 2;
  bool _isProcessing = false;
  bool _isSuccess = false;

  List<String> get _availableTimes {
    switch (widget.place.category) {
      case PlaceCategory.restaurants:
        return [
          '12:00 PM',
          '1:00 PM',
          '2:00 PM',
          '7:00 PM',
          '8:00 PM',
          '9:00 PM',
        ];
      case PlaceCategory.nightlife:
        return ['9:00 PM', '10:00 PM', '11:00 PM', '12:00 AM'];
      default:
        return [
          '9:00 AM',
          '10:00 AM',
          '11:00 AM',
          '2:00 PM',
          '3:00 PM',
          '4:00 PM',
        ];
    }
  }

  String get _actionText {
    switch (widget.place.category) {
      case PlaceCategory.restaurants:
        return AppLocalizations.of(context)!.reserveTable;
      case PlaceCategory.activities:
        return AppLocalizations.of(context)!.bookActivity;
      case PlaceCategory.attractions:
        return AppLocalizations.of(context)!.getTickets;
      case PlaceCategory.shopping:
        return AppLocalizations.of(context)!.claimOffer;
      case PlaceCategory.nightlife:
        return AppLocalizations.of(context)!.reserveSpot;
    }
  }

  String get _successTitle {
    switch (widget.place.category) {
      case PlaceCategory.restaurants:
        return AppLocalizations.of(context)!.tableReserved;
      case PlaceCategory.activities:
        return AppLocalizations.of(context)!.bookingConfirmed;
      case PlaceCategory.attractions:
        return AppLocalizations.of(context)!.ticketsBooked;
      case PlaceCategory.shopping:
        return AppLocalizations.of(context)!.dealClaimed;
      case PlaceCategory.nightlife:
        return AppLocalizations.of(context)!.spotReserved;
    }
  }

  String _getCategoryName(PlaceCategory category) {
    switch (category) {
      case PlaceCategory.restaurants:
        return AppLocalizations.of(context)!.restaurant;
      case PlaceCategory.activities:
        return AppLocalizations.of(context)!.activities;
      case PlaceCategory.attractions:
        return AppLocalizations.of(context)!.sights;
      case PlaceCategory.shopping:
        return AppLocalizations.of(context)!.shopping;
      case PlaceCategory.nightlife:
        return 'Nightlife';
    }
  }

  Future<void> _processBooking() async {
    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    final reservation = Reservation(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: widget.place.name,
      imageUrl: widget.place.imageUrl,
      type: ReservationType.place,
      status: ReservationStatus.upcoming,
      date: _selectedDate,
      time: _selectedTime,
      guestCount: _guestCount,
      price: widget.place.price,
      category: _getCategoryName(widget.place.category),
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
        place: widget.place,
        date: _selectedDate,
        time: _selectedTime,
        guestCount: _guestCount,
        successTitle: _successTitle,
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
          Text(_successTitle, style: AppTextStyles.headlineMedium),
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
          Text(_actionText, style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.place.name,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          _buildDateSelector(),
          const SizedBox(height: AppSpacing.lg),

          _buildTimeSelector(),
          const SizedBox(height: AppSpacing.lg),

          _buildGuestSelector(),
          const SizedBox(height: AppSpacing.lg),

          if (widget.place.price != null) ...[
            _buildPriceSummary(),
            const SizedBox(height: AppSpacing.lg),
          ],

          PrimaryButton(
            text: _isProcessing
                ? AppLocalizations.of(context)!.processing
                : '${AppLocalizations.of(context)!.confirm} $_actionText',
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
          widget.place.category == PlaceCategory.restaurants
              ? 'Party Size'
              : 'Number of Guests',
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
                onPressed: _guestCount < 10
                    ? () => setState(() => _guestCount++)
                    : null,
                icon: const Icon(Icons.add_circle_outline),
                color: _guestCount < 10 ? AppColors.primary : AppColors.divider,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    final pricePerPerson = widget.place.price ?? 0;
    final subtotal = pricePerPerson * _guestCount;
    final serviceFee = subtotal * 0.05;
    final total = subtotal + serviceFee;

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        children: [
          _buildPriceRow(
            '${Formatters.currency(pricePerPerson)} x $_guestCount guests',
            Formatters.currency(subtotal),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildPriceRow('Service fee', Formatters.currency(serviceFee)),
          const Divider(height: AppSpacing.lg),
          _buildPriceRow('Total', Formatters.currency(total), isTotal: true),
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
  final Place place;
  final DateTime date;
  final String time;
  final int guestCount;
  final String successTitle;

  const _SuccessDialog({
    required this.place,
    required this.date,
    required this.time,
    required this.guestCount,
    required this.successTitle,
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
            Text(successTitle, style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your reservation has been confirmed.',
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
                  _buildInfoRow(Icons.place_outlined, place.name),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    Formatters.date(date, format: 'EEEE, MMM dd'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(Icons.access_time, time),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(Icons.people_outline, '$guestCount guests'),
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
