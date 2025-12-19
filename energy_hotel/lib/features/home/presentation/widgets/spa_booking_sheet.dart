import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../profile/domain/entities/reservation.dart';
import '../../../profile/presentation/providers/reservations_provider.dart';

class SpaBookingSheet extends ConsumerStatefulWidget {
  const SpaBookingSheet({super.key});

  @override
  ConsumerState<SpaBookingSheet> createState() => _SpaBookingSheetState();
}

class _SpaBookingSheetState extends ConsumerState<SpaBookingSheet> {
  int _currentStep = 0;
  String? _selectedCategory;
  Map<String, dynamic>? _selectedTreatment;
  final List<String> _selectedAddOns = [];
  String? _selectedTherapist;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '10:00 AM';
  final TextEditingController _specialRequestsController =
      TextEditingController();
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'massage',
      'name': 'Massage Therapy',
      'icon': Icons.spa,
      'description': 'Relaxing body treatments',
    },
    {
      'id': 'facial',
      'name': 'Facial Treatments',
      'icon': Icons.face_retouching_natural,
      'description': 'Skin rejuvenation',
    },
    {
      'id': 'body',
      'name': 'Body Treatments',
      'icon': Icons.accessibility_new,
      'description': 'Wraps & scrubs',
    },
    {
      'id': 'packages',
      'name': 'Spa Packages',
      'icon': Icons.card_giftcard,
      'description': 'Complete experiences',
    },
  ];

  List<Map<String, dynamic>> get _treatments {
    switch (_selectedCategory) {
      case 'massage':
        return [
          {
            'id': 'swedish',
            'name': 'Swedish Massage',
            'description':
                'Classic relaxation massage with long, flowing strokes',
            'duration': '60 min',
            'price': 120.0,
            'image':
                'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400',
          },
          {
            'id': 'deep_tissue',
            'name': 'Deep Tissue Massage',
            'description': 'Intense pressure to release muscle tension',
            'duration': '60 min',
            'price': 140.0,
            'image':
                'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?w=400',
          },
          {
            'id': 'hot_stone',
            'name': 'Hot Stone Therapy',
            'description': 'Heated stones for deep relaxation',
            'duration': '75 min',
            'price': 160.0,
            'image':
                'https://images.unsplash.com/photo-1600334129128-685c5582fd35?w=400',
          },
          {
            'id': 'aromatherapy',
            'name': 'Aromatherapy Massage',
            'description': 'Essential oils for mind and body balance',
            'duration': '60 min',
            'price': 130.0,
            'image':
                'https://images.unsplash.com/photo-1507652313519-d4e9174996dd?w=400',
          },
          {
            'id': 'couples',
            'name': 'Couples Massage',
            'description': 'Side-by-side relaxation for two',
            'duration': '60 min',
            'price': 240.0,
            'image':
                'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=400',
          },
        ];
      case 'facial':
        return [
          {
            'id': 'hydrating',
            'name': 'Hydrating Facial',
            'description': 'Deep moisture for dry skin',
            'duration': '45 min',
            'price': 95.0,
            'image':
                'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?w=400',
          },
          {
            'id': 'anti_aging',
            'name': 'Anti-Aging Facial',
            'description': 'Reduce fine lines and wrinkles',
            'duration': '60 min',
            'price': 150.0,
            'image':
                'https://images.unsplash.com/photo-1512290923902-8a9f81dc236c?w=400',
          },
          {
            'id': 'deep_cleanse',
            'name': 'Deep Cleanse Facial',
            'description': 'Purify and detoxify your skin',
            'duration': '50 min',
            'price': 110.0,
            'image':
                'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400',
          },
          {
            'id': 'vitamin_c',
            'name': 'Vitamin C Glow',
            'description': 'Brighten and even skin tone',
            'duration': '45 min',
            'price': 120.0,
            'image':
                'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?w=400',
          },
        ];
      case 'body':
        return [
          {
            'id': 'body_scrub',
            'name': 'Exfoliating Body Scrub',
            'description': 'Remove dead skin cells for smooth skin',
            'duration': '45 min',
            'price': 85.0,
            'image':
                'https://images.unsplash.com/photo-1515377905703-c4788e51af15?w=400',
          },
          {
            'id': 'mud_wrap',
            'name': 'Detox Mud Wrap',
            'description': 'Draw out impurities with mineral-rich mud',
            'duration': '60 min',
            'price': 120.0,
            'image':
                'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400',
          },
          {
            'id': 'seaweed',
            'name': 'Seaweed Body Wrap',
            'description': 'Nourish skin with ocean minerals',
            'duration': '60 min',
            'price': 130.0,
            'image':
                'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=400',
          },
        ];
      case 'packages':
        return [
          {
            'id': 'half_day',
            'name': 'Half Day Retreat',
            'description': 'Massage + Facial + Light lunch',
            'duration': '3 hours',
            'price': 280.0,
            'image':
                'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=400',
          },
          {
            'id': 'full_day',
            'name': 'Full Day Escape',
            'description': 'Complete spa journey with all treatments',
            'duration': '6 hours',
            'price': 450.0,
            'image':
                'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=400',
          },
          {
            'id': 'couples_retreat',
            'name': 'Romantic Couples Retreat',
            'description': 'Couples massage + champagne + chocolates',
            'duration': '2 hours',
            'price': 350.0,
            'image':
                'https://images.unsplash.com/photo-1519823551278-64ac92734fb1?w=400',
          },
        ];
      default:
        return [];
    }
  }

  final List<Map<String, dynamic>> _addOns = [
    {'id': 'scalp', 'name': 'Scalp Massage', 'price': 25.0},
    {'id': 'foot', 'name': 'Foot Reflexology', 'price': 35.0},
    {'id': 'eye', 'name': 'Eye Treatment', 'price': 20.0},
    {'id': 'hand', 'name': 'Hand & Arm Massage', 'price': 20.0},
    {'id': 'upgrade_oil', 'name': 'Premium Oil Upgrade', 'price': 15.0},
    {'id': 'extended', 'name': 'Extended Time (+15 min)', 'price': 30.0},
  ];

  final List<Map<String, dynamic>> _therapists = [
    {'id': 'any', 'name': 'No Preference', 'specialty': 'First available'},
    {'id': 'maria', 'name': 'Maria S.', 'specialty': 'Deep Tissue Expert'},
    {'id': 'john', 'name': 'John D.', 'specialty': 'Swedish & Relaxation'},
    {'id': 'lisa', 'name': 'Lisa M.', 'specialty': 'Facial Specialist'},
    {'id': 'carlos', 'name': 'Carlos R.', 'specialty': 'Hot Stone Therapy'},
  ];

  final List<String> _availableTimes = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  double get _totalPrice {
    double total = _selectedTreatment?['price'] ?? 0.0;
    for (final addOnId in _selectedAddOns) {
      final addOn = _addOns.firstWhere((a) => a['id'] == addOnId);
      total += addOn['price'] as double;
    }
    return total;
  }

  Future<void> _processBooking() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    final reservation = Reservation(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: _selectedTreatment!['name'] as String,
      imageUrl: _selectedTreatment!['image'] as String,
      type: ReservationType.service,
      status: ReservationStatus.upcoming,
      date: _selectedDate,
      time: _selectedTime,
      guestCount: 1,
      price: _totalPrice,
      category: 'Spa',
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
                  Icons.spa,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppLocalizations.of(context)!.spaBooked,
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                AppLocalizations.of(context)!.relaxPrepare,
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
                      Icons.spa,
                      _selectedTreatment!['name'] as String,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      Icons.calendar_today,
                      Formatters.date(_selectedDate, format: 'EEEE, MMM dd'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(Icons.access_time, _selectedTime),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      Icons.attach_money,
                      Formatters.currency(_totalPrice),
                    ),
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
        maxHeight: MediaQuery.of(context).size.height * 0.9,
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
            _buildStepIndicator(),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppDurations.normal,
                child: _buildCurrentStep(),
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
                  onPressed: () => setState(() => _currentStep--),
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.textSecondary,
                ),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primaryWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: const Icon(Icons.spa, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.spaWellness,
                      style: AppTextStyles.headlineMedium,
                    ),
                    Text(_getStepTitle(), style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    final l10n = AppLocalizations.of(context)!;
    switch (_currentStep) {
      case 0:
        return l10n.selectTreatmentCategory;
      case 1:
        return l10n.chooseYourTreatment;
      case 2:
        return l10n.addEnhancements;
      case 3:
        return l10n.selectDateTime;
      default:
        return '';
    }
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = index <= _currentStep;
          final isCompleted = index < _currentStep;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index < 3 ? AppSpacing.xs : 0),
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
              child: isCompleted ? null : null,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildCategorySelection();
      case 1:
        return _buildTreatmentSelection();
      case 2:
        return _buildAddOnsSelection();
      case 3:
        return _buildDateTimeSelection();
      default:
        return const SizedBox();
    }
  }

  Widget _buildCategorySelection() {
    return ListView.builder(
      key: const ValueKey('categories'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        final isSelected = _selectedCategory == category['id'];
        return GestureDetector(
          onTap: () =>
              setState(() => _selectedCategory = category['id'] as String),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['name'] as String,
                        style: AppTextStyles.titleMedium,
                      ),
                      Text(
                        category['description'] as String,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.chevron_right,
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textTertiary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTreatmentSelection() {
    return ListView.builder(
      key: const ValueKey('treatments'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _treatments.length,
      itemBuilder: (context, index) {
        final treatment = _treatments[index];
        final isSelected = _selectedTreatment?['id'] == treatment['id'];
        return GestureDetector(
          onTap: () => setState(() => _selectedTreatment = treatment),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              treatment['name'] as String,
                              style: AppTextStyles.titleMedium,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              treatment['description'] as String,
                              style: AppTextStyles.bodySmall,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: AppColors.textTertiary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  treatment['duration'] as String,
                                  style: AppTextStyles.caption,
                                ),
                                const Spacer(),
                                Text(
                                  Formatters.currency(
                                    treatment['price'] as double,
                                  ),
                                  style: AppTextStyles.titleMedium.copyWith(
                                    color: AppColors.accent,
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOnsSelection() {
    return SingleChildScrollView(
      key: const ValueKey('addons'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.enhanceExperience,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            AppLocalizations.of(context)!.addExtraTreatments,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          ..._addOns.map((addOn) {
            final isSelected = _selectedAddOns.contains(addOn['id']);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedAddOns.remove(addOn['id']);
                  } else {
                    _selectedAddOns.add(addOn['id'] as String);
                  }
                });
              },
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
                        borderRadius: BorderRadius.circular(4),
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
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        addOn['name'] as String,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    Text(
                      '+${Formatters.currency(addOn['price'] as double)}',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppLocalizations.of(context)!.therapistPreference,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          ..._therapists.map((therapist) {
            final isSelected = _selectedTherapist == therapist['id'];
            return GestureDetector(
              onTap: () => setState(
                () => _selectedTherapist = therapist['id'] as String,
              ),
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
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            therapist['name'] as String,
                            style: AppTextStyles.bodyMedium,
                          ),
                          Text(
                            therapist['specialty'] as String,
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
          Text(
            AppLocalizations.of(context)!.specialRequests,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.anyAllergies,
              hintStyle: AppTextStyles.bodySmall,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
            controller: _specialRequestsController,
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return SingleChildScrollView(
      key: const ValueKey('datetime'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.selectDate,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 14,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index + 1));
                final isSelected =
                    _selectedDate.day == date.day &&
                    _selectedDate.month == date.month;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDate = date),
                  child: AnimatedContainer(
                    duration: AppDurations.fast,
                    width: 60,
                    margin: const EdgeInsets.only(right: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.surface,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Formatters.date(date, format: 'EEE'),
                          style: AppTextStyles.caption.copyWith(
                            color: isSelected
                                ? Colors.white70
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          Formatters.date(date, format: 'MMM'),
                          style: AppTextStyles.caption.copyWith(
                            color: isSelected
                                ? Colors.white70
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppLocalizations.of(context)!.selectTime,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _availableTimes.map((time) {
              final isSelected = _selectedTime == time;
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
          const SizedBox(height: AppSpacing.xl),
          _buildSummary(),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.bookingSummary,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildSummaryRow(
            _selectedTreatment!['name'] as String,
            _selectedTreatment!['price'] as double,
          ),
          ..._selectedAddOns.map((id) {
            final addOn = _addOns.firstWhere((a) => a['id'] == id);
            return _buildSummaryRow(
              addOn['name'] as String,
              addOn['price'] as double,
            );
          }),
          const Divider(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.total,
                style: AppTextStyles.titleMedium,
              ),
              Text(
                Formatters.currency(_totalPrice),
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String name, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: AppTextStyles.bodySmall),
          Text(Formatters.currency(price), style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final canProceed = _currentStep == 0
        ? _selectedCategory != null
        : _currentStep == 1
        ? _selectedTreatment != null
        : true;

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
      child: Row(
        children: [
          if (_currentStep == 3) ...[
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
                    Formatters.currency(_totalPrice),
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            flex: _currentStep == 3 ? 2 : 1,
            child: PrimaryButton(
              text: _currentStep == 3
                  ? (_isProcessing ? 'Booking...' : 'Confirm Booking')
                  : 'Continue',
              isLoading: _isProcessing,
              onPressed: canProceed && !_isProcessing
                  ? () {
                      if (_currentStep < 3) {
                        setState(() => _currentStep++);
                      } else {
                        _processBooking();
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
