import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class HousekeepingSheet extends ConsumerStatefulWidget {
  const HousekeepingSheet({super.key});

  @override
  ConsumerState<HousekeepingSheet> createState() => _HousekeepingSheetState();
}

class _HousekeepingSheetState extends ConsumerState<HousekeepingSheet> {
  int _currentTab = 0;
  final Set<String> _selectedServices = {};
  final Set<String> _selectedAmenities = {};
  String _preferredTime = 'anytime';
  bool _doNotDisturb = false;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _cleaningServices = [
    {
      'id': 'full_clean',
      'name': 'Full Room Cleaning',
      'description':
          'Complete cleaning including bed making, vacuuming, and bathroom',
      'icon': Icons.cleaning_services,
      'duration': '30-45 min',
    },
    {
      'id': 'quick_tidy',
      'name': 'Quick Tidy Up',
      'description': 'Light cleaning, trash removal, and bed making',
      'icon': Icons.auto_fix_high,
      'duration': '15-20 min',
    },
    {
      'id': 'turndown',
      'name': 'Turndown Service',
      'description': 'Evening bed preparation with chocolates',
      'icon': Icons.nights_stay,
      'duration': '10 min',
    },
    {
      'id': 'deep_clean',
      'name': 'Deep Cleaning',
      'description': 'Thorough sanitization and detailed cleaning',
      'icon': Icons.sanitizer,
      'duration': '60 min',
    },
  ];

  final List<Map<String, dynamic>> _amenities = [
    {'id': 'towels', 'name': 'Extra Towels', 'icon': Icons.dry_cleaning},
    {'id': 'pillows', 'name': 'Extra Pillows', 'icon': Icons.airline_seat_flat},
    {'id': 'blanket', 'name': 'Extra Blanket', 'icon': Icons.bed},
    {'id': 'toiletries', 'name': 'Toiletries Kit', 'icon': Icons.soap},
    {'id': 'bathrobe', 'name': 'Bathrobe', 'icon': Icons.checkroom},
    {'id': 'slippers', 'name': 'Slippers', 'icon': Icons.do_not_step},
    {'id': 'iron', 'name': 'Iron & Board', 'icon': Icons.iron},
    {'id': 'hangers', 'name': 'Extra Hangers', 'icon': Icons.dry},
    {'id': 'coffee', 'name': 'Coffee/Tea Refill', 'icon': Icons.coffee},
    {'id': 'water', 'name': 'Bottled Water', 'icon': Icons.water_drop},
    {'id': 'minibar', 'name': 'Minibar Refill', 'icon': Icons.liquor},
    {'id': 'ice', 'name': 'Ice Bucket', 'icon': Icons.ac_unit},
  ];

  final List<Map<String, dynamic>> _timeSlots = [
    {'id': 'anytime', 'name': 'Anytime', 'subtitle': 'First available'},
    {'id': 'morning', 'name': 'Morning', 'subtitle': '8 AM - 12 PM'},
    {'id': 'afternoon', 'name': 'Afternoon', 'subtitle': '12 PM - 5 PM'},
    {'id': 'evening', 'name': 'Evening', 'subtitle': '5 PM - 9 PM'},
  ];

  Future<void> _submitRequest() async {
    if (_selectedServices.isEmpty && _selectedAmenities.isEmpty) return;

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
              Text('Request Submitted!', style: AppTextStyles.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Our housekeeping team will attend to your request shortly.',
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
                    if (_selectedServices.isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.cleaning_services,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              '${_selectedServices.length} service(s) requested',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    if (_selectedAmenities.isNotEmpty) ...[
                      if (_selectedServices.isNotEmpty)
                        const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          const Icon(
                            Icons.inventory_2,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              '${_selectedAmenities.length} amenity item(s)',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            _timeSlots.firstWhere(
                                  (t) => t['id'] == _preferredTime,
                                )['name']
                                as String,
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
            _buildTabs(),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppDurations.normal,
                child: _currentTab == 0
                    ? _buildCleaningTab()
                    : _currentTab == 1
                    ? _buildAmenitiesTab()
                    : _buildScheduleTab(),
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
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primaryWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: const Icon(
                  Icons.cleaning_services,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Housekeeping', style: AppTextStyles.headlineMedium),
                    Text(
                      'Request services & amenities',
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

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Row(
        children: [
          _buildTab(0, 'Cleaning', Icons.cleaning_services),
          _buildTab(1, 'Amenities', Icons.inventory_2),
          _buildTab(2, 'Schedule', Icons.schedule),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = _currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentTab = index),
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCleaningTab() {
    return ListView(
      key: const ValueKey('cleaning'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Do Not Disturb toggle
        Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: _doNotDisturb
                ? AppColors.error.withValues(alpha: 0.1)
                : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            border: _doNotDisturb
                ? Border.all(color: AppColors.error.withValues(alpha: 0.3))
                : null,
          ),
          child: Row(
            children: [
              Icon(
                Icons.do_not_disturb_on,
                color: _doNotDisturb
                    ? AppColors.error
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Do Not Disturb', style: AppTextStyles.titleSmall),
                    Text(
                      'Housekeeping will not enter your room',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              Switch(
                value: _doNotDisturb,
                onChanged: (value) => setState(() => _doNotDisturb = value),
                activeColor: AppColors.error,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Cleaning Services', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ..._cleaningServices.map((service) => _buildServiceCard(service)),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    final isSelected = _selectedServices.contains(service['id']);
    return GestureDetector(
      onTap: _doNotDisturb
          ? null
          : () {
              setState(() {
                if (isSelected) {
                  _selectedServices.remove(service['id']);
                } else {
                  _selectedServices.add(service['id'] as String);
                }
              });
            },
      child: AnimatedContainer(
        duration: AppDurations.fast,
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: _doNotDisturb
              ? AppColors.surfaceVariant.withValues(alpha: 0.5)
              : isSelected
              ? AppColors.primaryWithOpacity(0.05)
              : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
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
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Icon(
                service['icon'] as IconData,
                color: isSelected ? Colors.white : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['name'] as String,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: _doNotDisturb ? AppColors.textTertiary : null,
                    ),
                  ),
                  Text(
                    service['description'] as String,
                    style: AppTextStyles.caption.copyWith(
                      color: _doNotDisturb
                          ? AppColors.textTertiary
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '~${service['duration']}',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (!_doNotDisturb)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: 2,
                  ),
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenitiesTab() {
    return GridView.builder(
      key: const ValueKey('amenities'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.9,
      ),
      itemCount: _amenities.length,
      itemBuilder: (context, index) {
        final amenity = _amenities[index];
        final isSelected = _selectedAmenities.contains(amenity['id']);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedAmenities.remove(amenity['id']);
              } else {
                _selectedAmenities.add(amenity['id'] as String);
              }
            });
          },
          child: AnimatedContainer(
            duration: AppDurations.fast,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryWithOpacity(0.1)
                  : AppColors.surface,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    amenity['icon'] as IconData,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    size: 24,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  amenity['name'] as String,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScheduleTab() {
    return ListView(
      key: const ValueKey('schedule'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Preferred Time', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        ..._timeSlots.map((slot) {
          final isSelected = _preferredTime == slot['id'];
          return GestureDetector(
            onTap: () => setState(() => _preferredTime = slot['id'] as String),
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
                ),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: 2,
                      ),
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slot['name'] as String,
                          style: AppTextStyles.titleSmall,
                        ),
                        Text(
                          slot['subtitle'] as String,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.info, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Requests are typically fulfilled within 30 minutes during selected time window.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    final hasSelection =
        _selectedServices.isNotEmpty || _selectedAmenities.isNotEmpty;
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasSelection)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  if (_selectedServices.isNotEmpty)
                    _buildSelectionChip(
                      '${_selectedServices.length} service(s)',
                      Icons.cleaning_services,
                    ),
                  if (_selectedServices.isNotEmpty &&
                      _selectedAmenities.isNotEmpty)
                    const SizedBox(width: AppSpacing.sm),
                  if (_selectedAmenities.isNotEmpty)
                    _buildSelectionChip(
                      '${_selectedAmenities.length} item(s)',
                      Icons.inventory_2,
                    ),
                ],
              ),
            ),
          PrimaryButton(
            text: _isProcessing
                ? 'Submitting...'
                : _doNotDisturb
                ? 'Set Do Not Disturb'
                : hasSelection
                ? 'Submit Request'
                : 'Select Services or Amenities',
            isLoading: _isProcessing,
            onPressed: (_doNotDisturb || hasSelection) && !_isProcessing
                ? _submitRequest
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryWithOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
