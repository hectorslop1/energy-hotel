import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';

class TransportSheet extends ConsumerStatefulWidget {
  const TransportSheet({super.key});

  @override
  ConsumerState<TransportSheet> createState() => _TransportSheetState();
}

class _TransportSheetState extends ConsumerState<TransportSheet> {
  int _currentStep = 0;
  String? _selectedService;
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = 'Now';
  String _pickupLocation = 'Hotel Lobby';
  String _dropoffLocation = '';
  int _passengers = 1;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _services = [
    {
      'id': 'taxi',
      'name': 'Taxi',
      'description': 'Standard taxi service',
      'icon': Icons.local_taxi,
      'price': 'Metered',
      'eta': '5-10 min',
      'capacity': 4,
    },
    {
      'id': 'private_car',
      'name': 'Private Car',
      'description': 'Sedan with professional driver',
      'icon': Icons.directions_car,
      'price': '\$45',
      'eta': '10-15 min',
      'capacity': 4,
    },
    {
      'id': 'suv',
      'name': 'SUV',
      'description': 'Spacious SUV for groups',
      'icon': Icons.airport_shuttle,
      'price': '\$65',
      'eta': '10-15 min',
      'capacity': 6,
    },
    {
      'id': 'airport',
      'name': 'Airport Shuttle',
      'description': 'Direct to/from airport',
      'icon': Icons.flight,
      'price': '\$35/person',
      'eta': 'Scheduled',
      'capacity': 8,
    },
    {
      'id': 'valet',
      'name': 'Valet Service',
      'description': 'Retrieve your parked car',
      'icon': Icons.car_rental,
      'price': 'Included',
      'eta': '5-8 min',
      'capacity': 0,
    },
    {
      'id': 'rental',
      'name': 'Car Rental',
      'description': 'Rent a car for the day',
      'icon': Icons.key,
      'price': 'From \$89/day',
      'eta': '30 min',
      'capacity': 5,
    },
  ];

  final List<String> _timeSlots = [
    'Now',
    'In 15 min',
    'In 30 min',
    'In 1 hour',
    '6:00 AM',
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '12:00 PM',
    '2:00 PM',
    '4:00 PM',
    '6:00 PM',
    '8:00 PM',
  ];

  final List<String> _popularDestinations = [
    'Airport',
    'Downtown',
    'Shopping Mall',
    'Beach Club',
    'Golf Course',
    'Convention Center',
  ];

  Future<void> _requestTransport() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop();
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    final service = _services.firstWhere((s) => s['id'] == _selectedService);
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
                child: Icon(
                  service['icon'] as IconData,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                _selectedService == 'valet' ? 'Car Requested!' : 'Ride Booked!',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _selectedService == 'valet'
                    ? 'Your car will be ready at the main entrance.'
                    : 'Your driver is on the way.',
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
                        Icon(
                          service['icon'] as IconData,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            service['name'] as String,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            _selectedTime == 'Now'
                                ? 'ETA: ${service['eta']}'
                                : _selectedTime,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    if (_dropoffLocation.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              _dropoffLocation,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: 'Done',
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
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppDurations.normal,
                child: _currentStep == 0
                    ? _buildServiceSelection()
                    : _buildDetails(),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
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
              if (_currentStep > 0)
                IconButton(
                  onPressed: () => setState(() => _currentStep = 0),
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.textSecondary,
                ),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primaryWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: const Icon(
                  Icons.directions_car,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transportation', style: AppTextStyles.headlineMedium),
                    Text(
                      _currentStep == 0 ? 'Select a service' : 'Enter details',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSelection() {
    return ListView.builder(
      key: const ValueKey('services'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        final isSelected = _selectedService == service['id'];
        return GestureDetector(
          onTap: () =>
              setState(() => _selectedService = service['id'] as String),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryWithOpacity(0.05)
                  : AppColors.surface,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['name'] as String,
                        style: AppTextStyles.titleMedium,
                      ),
                      Text(
                        service['description'] as String,
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            service['price'] as String,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            service['eta'] as String,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.primary),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetails() {
    final service = _services.firstWhere((s) => s['id'] == _selectedService);
    final needsDestination = _selectedService != 'valet';

    return SingleChildScrollView(
      key: const ValueKey('details'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (needsDestination) ...[
            Text('Pickup Location', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Row(
                children: [
                  const Icon(Icons.my_location, color: AppColors.primary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _pickupLocation,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Change')),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Destination', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter destination',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (value) => _dropoffLocation = value,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: _popularDestinations.map((dest) {
                return GestureDetector(
                  onTap: () => setState(() => _dropoffLocation = dest),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadiusXl,
                      ),
                    ),
                    child: Text(dest, style: AppTextStyles.labelSmall),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text('When', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _timeSlots.take(8).map((time) {
              final isSelected = _selectedTime == time;
              return GestureDetector(
                onTap: () => setState(() => _selectedTime = time),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadiusXl,
                    ),
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
          if ((service['capacity'] as int) > 0) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Passengers', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                IconButton(
                  onPressed: _passengers > 1
                      ? () => setState(() => _passengers--)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: _passengers > 1
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
                Text('$_passengers', style: AppTextStyles.headlineSmall),
                IconButton(
                  onPressed: _passengers < (service['capacity'] as int)
                      ? () => setState(() => _passengers++)
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                  color: _passengers < (service['capacity'] as int)
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Max ${service['capacity']} passengers',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final canProceed = _selectedService != null;
    final canBook =
        _currentStep == 1 &&
        (_selectedService == 'valet' || _dropoffLocation.isNotEmpty);

    return Container(
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
      child: PrimaryButton(
        text: _currentStep == 0
            ? 'Continue'
            : (_isProcessing ? 'Requesting...' : 'Request Now'),
        isLoading: _isProcessing,
        onPressed: _currentStep == 0
            ? (canProceed ? () => setState(() => _currentStep = 1) : null)
            : (canBook && !_isProcessing ? _requestTransport : null),
      ),
    );
  }
}
