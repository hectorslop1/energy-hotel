import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class FeedbackSheet extends StatefulWidget {
  final String? serviceName;
  final String? serviceType;

  const FeedbackSheet({super.key, this.serviceName, this.serviceType});

  @override
  State<FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<FeedbackSheet> {
  int _overallRating = 0;
  final Map<String, int> _categoryRatings = {};
  final TextEditingController _feedbackController = TextEditingController();
  bool _isProcessing = false;

  List<String> get _categories {
    switch (widget.serviceType) {
      case 'dining':
        return ['Food Quality', 'Service', 'Ambiance', 'Value'];
      case 'spa':
        return ['Treatment Quality', 'Staff', 'Cleanliness', 'Relaxation'];
      case 'room':
        return ['Cleanliness', 'Comfort', 'Amenities', 'View'];
      default:
        return ['Service', 'Staff', 'Value', 'Experience'];
    }
  }

  Future<void> _submitFeedback() async {
    if (_overallRating == 0) return;

    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop();
      _showThankYouDialog();
    }
  }

  void _showThankYouDialog() {
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
                  Icons.favorite,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppLocalizations.of(context)!.thankYou,
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your feedback helps us improve our services.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              if (_overallRating >= 4) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.stars, color: AppColors.warning),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'You earned 50 loyalty points!',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverallRating(),
                    const SizedBox(height: AppSpacing.xl),
                    _buildCategoryRatings(),
                    const SizedBox(height: AppSpacing.xl),
                    _buildFeedbackInput(),
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
                child: const Icon(Icons.rate_review, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rate Your Experience',
                      style: AppTextStyles.headlineMedium,
                    ),
                    if (widget.serviceName != null)
                      Text(widget.serviceName!, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.overallRating,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final rating = index + 1;
            return GestureDetector(
              onTap: () => setState(() => _overallRating = rating),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  rating <= _overallRating ? Icons.star : Icons.star_border,
                  color: rating <= _overallRating
                      ? Colors.amber
                      : AppColors.textTertiary,
                  size: 48,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _getRatingText(),
          style: AppTextStyles.bodyMedium.copyWith(
            color: _overallRating > 0
                ? AppColors.textPrimary
                : AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  String _getRatingText() {
    switch (_overallRating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent!';
      default:
        return 'Tap to rate';
    }
  }

  Widget _buildCategoryRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.rateByCategory,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSpacing.md),
        ..._categories.map((category) {
          final rating = _categoryRatings[category] ?? 0;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(category, style: AppTextStyles.bodyMedium),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: List.generate(5, (index) {
                      final starRating = index + 1;
                      return GestureDetector(
                        onTap: () => setState(
                          () => _categoryRatings[category] = starRating,
                        ),
                        child: Icon(
                          starRating <= rating ? Icons.star : Icons.star_border,
                          color: starRating <= rating
                              ? Colors.amber
                              : AppColors.textTertiary,
                          size: 28,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFeedbackInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.additionalComments,
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.leaveComment,
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
          controller: _feedbackController,
        ),
      ],
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
            ? AppLocalizations.of(context)!.submitting
            : AppLocalizations.of(context)!.submitFeedback,
        isLoading: _isProcessing,
        onPressed: _overallRating > 0 && !_isProcessing
            ? _submitFeedback
            : null,
      ),
    );
  }
}
