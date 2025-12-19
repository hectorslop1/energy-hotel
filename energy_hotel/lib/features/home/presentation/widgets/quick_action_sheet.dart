import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class QuickActionSheet extends StatefulWidget {
  final String title;
  final IconData icon;

  const QuickActionSheet({super.key, required this.title, required this.icon});

  @override
  State<QuickActionSheet> createState() => _QuickActionSheetState();
}

class _QuickActionSheetState extends State<QuickActionSheet> {
  String? _selectedOption;
  bool _isProcessing = false;

  List<Map<String, dynamic>> get _options {
    switch (widget.title) {
      case 'Spa':
        return [
          {
            'id': 'massage',
            'name': 'Full Body Massage',
            'duration': '60 min',
            'price': 120.0,
          },
          {
            'id': 'facial',
            'name': 'Facial Treatment',
            'duration': '45 min',
            'price': 85.0,
          },
          {
            'id': 'aromatherapy',
            'name': 'Aromatherapy Session',
            'duration': '30 min',
            'price': 65.0,
          },
          {
            'id': 'couples',
            'name': 'Couples Spa Package',
            'duration': '90 min',
            'price': 220.0,
          },
        ];
      case 'Dining':
        return [
          {
            'id': 'breakfast',
            'name': 'Breakfast Buffet',
            'duration': '7-10 AM',
            'price': 35.0,
          },
          {
            'id': 'lunch',
            'name': 'Lunch Menu',
            'duration': '12-3 PM',
            'price': 45.0,
          },
          {
            'id': 'dinner',
            'name': 'Dinner Reservation',
            'duration': '6-10 PM',
            'price': 75.0,
          },
          {
            'id': 'roomservice',
            'name': 'In-Room Dining',
            'duration': '24 hours',
            'price': 0.0,
          },
        ];
      case 'Pool':
        return [
          {
            'id': 'daypass',
            'name': 'Pool Day Pass',
            'duration': '9 AM - 8 PM',
            'price': 0.0,
          },
          {
            'id': 'cabana',
            'name': 'Private Cabana',
            'duration': 'Half day',
            'price': 150.0,
          },
          {
            'id': 'towels',
            'name': 'Premium Towel Service',
            'duration': 'Per day',
            'price': 15.0,
          },
          {
            'id': 'drinks',
            'name': 'Poolside Drinks',
            'duration': 'Per order',
            'price': 12.0,
          },
        ];
      case 'Room Service':
        return [
          {
            'id': 'cleaning',
            'name': 'Room Cleaning',
            'duration': '30 min',
            'price': 0.0,
          },
          {
            'id': 'turndown',
            'name': 'Turndown Service',
            'duration': 'Evening',
            'price': 0.0,
          },
          {
            'id': 'laundry',
            'name': 'Laundry Service',
            'duration': 'Same day',
            'price': 25.0,
          },
          {
            'id': 'minibar',
            'name': 'Minibar Refill',
            'duration': 'On request',
            'price': 0.0,
          },
        ];
      default:
        return [];
    }
  }

  Future<void> _requestService() async {
    if (_selectedOption == null) return;

    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop();
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    final selectedService = _options.firstWhere(
      (o) => o['id'] == _selectedOption,
    );

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
              Text(
                AppLocalizations.of(context)!.requestSubmitted,
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your request has been received.',
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
                    _buildInfoRow(
                      widget.icon,
                      selectedService['name'] as String,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      Icons.access_time,
                      selectedService['duration'] as String,
                    ),
                    if ((selectedService['price'] as double) > 0) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        Icons.attach_money,
                        '\$${(selectedService['price'] as double).toStringAsFixed(0)}',
                      ),
                    ],
                  ],
                ),
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
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
            _buildHeader(),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    ..._options.map((option) => _buildOptionCard(option)),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
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
                child: Icon(widget.icon, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(widget.title, style: AppTextStyles.headlineMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Select a service to request',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(Map<String, dynamic> option) {
    final isSelected = _selectedOption == option['id'];
    final price = option['price'] as double;

    return GestureDetector(
      onTap: () => setState(() => _selectedOption = option['id'] as String),
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
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option['name'] as String,
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    option['duration'] as String,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            if (price > 0)
              Text(
                '\$${price.toStringAsFixed(0)}',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.accent,
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(
                    AppSpacing.borderRadiusXl,
                  ),
                ),
                child: Text(
                  'Free',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
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
        text: _isProcessing
            ? AppLocalizations.of(context)!.processing
            : AppLocalizations.of(context)!.requestService,
        isLoading: _isProcessing,
        onPressed: _selectedOption == null || _isProcessing
            ? null
            : _requestService,
      ),
    );
  }
}
