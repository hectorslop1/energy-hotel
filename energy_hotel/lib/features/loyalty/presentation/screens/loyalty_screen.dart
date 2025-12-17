import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';

class LoyaltyScreen extends StatefulWidget {
  const LoyaltyScreen({super.key});

  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  final int _currentPoints = 2750;
  final String _currentTier = 'Gold';
  final int _pointsToNextTier = 2250;
  final int _nightsThisYear = 12;

  final List<Map<String, dynamic>> _tiers = [
    {
      'name': 'Silver',
      'minPoints': 0,
      'color': Colors.grey,
      'benefits': ['5% off dining', 'Late checkout (1 PM)', 'Welcome drink'],
    },
    {
      'name': 'Gold',
      'minPoints': 2000,
      'color': Colors.amber,
      'benefits': [
        '10% off dining',
        'Late checkout (3 PM)',
        'Room upgrade',
        'Spa discount',
      ],
    },
    {
      'name': 'Platinum',
      'minPoints': 5000,
      'color': Colors.blueGrey,
      'benefits': [
        '15% off everything',
        'Late checkout (6 PM)',
        'Suite upgrade',
        'Free spa treatment',
        'Airport transfer',
      ],
    },
  ];

  final List<Map<String, dynamic>> _rewards = [
    {
      'id': 'r1',
      'name': 'Free Night Stay',
      'description': 'Redeem for one complimentary night',
      'points': 5000,
      'icon': Icons.hotel,
    },
    {
      'id': 'r2',
      'name': 'Spa Treatment',
      'description': '60-minute massage or facial',
      'points': 2000,
      'icon': Icons.spa,
    },
    {
      'id': 'r3',
      'name': 'Dinner for Two',
      'description': 'At any hotel restaurant',
      'points': 1500,
      'icon': Icons.restaurant,
    },
    {
      'id': 'r4',
      'name': 'Room Upgrade',
      'description': 'Upgrade to next room category',
      'points': 1000,
      'icon': Icons.upgrade,
    },
    {
      'id': 'r5',
      'name': 'Pool Cabana',
      'description': 'Half-day private cabana',
      'points': 800,
      'icon': Icons.beach_access,
    },
    {
      'id': 'r6',
      'name': 'Breakfast Buffet',
      'description': 'Complimentary breakfast for two',
      'points': 500,
      'icon': Icons.free_breakfast,
    },
  ];

  final List<Map<String, dynamic>> _history = [
    {
      'description': 'Room booking - 3 nights',
      'points': 900,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'type': 'earned',
    },
    {
      'description': 'Spa - Swedish Massage',
      'points': 120,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'type': 'earned',
    },
    {
      'description': 'Dining - La Terraza',
      'points': 75,
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'type': 'earned',
    },
    {
      'description': 'Redeemed: Breakfast Buffet',
      'points': -500,
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'type': 'redeemed',
    },
    {
      'description': 'Welcome bonus',
      'points': 500,
      'date': DateTime.now().subtract(const Duration(days: 30)),
      'type': 'bonus',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildPointsCard()),
          SliverToBoxAdapter(child: _buildTierProgress()),
          SliverToBoxAdapter(child: _buildBenefits()),
          SliverToBoxAdapter(child: _buildRewardsSection()),
          SliverToBoxAdapter(child: _buildHistorySection()),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Energy Rewards',
          style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPointsCard() {
    final tierColor =
        _tiers.firstWhere((t) => t['name'] == _currentTier)['color'] as Color;

    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tierColor.withValues(alpha: 0.8), tierColor],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: tierColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.stars, color: Colors.white, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '$_currentTier Member',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Member since 2023',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Icon(
                  _currentTier == 'Platinum'
                      ? Icons.diamond
                      : _currentTier == 'Gold'
                      ? Icons.workspace_premium
                      : Icons.card_membership,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Available Points',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ),
          Text(
            Formatters.number(_currentPoints),
            style: AppTextStyles.displayMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Nights', _nightsThisYear.toString()),
              Container(width: 1, height: 30, color: Colors.white24),
              _buildStatItem('Tier', _currentTier),
              Container(width: 1, height: 30, color: Colors.white24),
              _buildStatItem('To Next', Formatters.number(_pointsToNextTier)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
        ),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildTierProgress() {
    final progress = _currentPoints / 5000;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tier Progress', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Expanded(
                  flex: 60,
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: ((progress - 0.4) / 0.6).clamp(0, 1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTierMarker('Silver', Colors.grey, true),
              _buildTierMarker('Gold', Colors.amber, true),
              _buildTierMarker('Platinum', Colors.blueGrey, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTierMarker(String name, Color color, bool achieved) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: achieved ? color : AppColors.surfaceVariant,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: AppTextStyles.caption.copyWith(
            color: achieved ? color : AppColors.textTertiary,
            fontWeight: achieved ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefits() {
    final currentTierData = _tiers.firstWhere((t) => t['name'] == _currentTier);
    final benefits = currentTierData['benefits'] as List<String>;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Benefits', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: benefits
                  .map(
                    (benefit) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(benefit, style: AppTextStyles.bodyMedium),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Redeem Rewards', style: AppTextStyles.titleMedium),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _rewards.length,
              itemBuilder: (context, index) {
                final reward = _rewards[index];
                final canRedeem = _currentPoints >= (reward['points'] as int);
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(
                    right: index < _rewards.length - 1 ? AppSpacing.sm : 0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: canRedeem
                              ? AppColors.primaryWithOpacity(0.1)
                              : AppColors.surfaceVariant,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppSpacing.borderRadius),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            reward['icon'] as IconData,
                            size: 32,
                            color: canRedeem
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reward['name'] as String,
                              style: AppTextStyles.titleSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              reward['description'] as String,
                              style: AppTextStyles.caption,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${Formatters.number(reward['points'] as int)} pts',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: canRedeem
                                        ? AppColors.accent
                                        : AppColors.textTertiary,
                                  ),
                                ),
                                if (canRedeem)
                                  GestureDetector(
                                    onTap: () => _showRedeemDialog(reward),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(
                                          AppSpacing.borderRadiusXl,
                                        ),
                                      ),
                                      child: Text(
                                        'Redeem',
                                        style: AppTextStyles.caption.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRedeemDialog(Map<String, dynamic> reward) {
    showDialog(
      context: context,
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
                  color: AppColors.primaryWithOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  reward['icon'] as IconData,
                  color: AppColors.primary,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Redeem Reward?', style: AppTextStyles.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(reward['name'] as String, style: AppTextStyles.titleMedium),
              Text(
                '${Formatters.number(reward['points'] as int)} points',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Confirm',
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${reward['name']} redeemed!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Points History', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          ..._history.map((item) {
            final isEarned = (item['points'] as int) > 0;
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isEarned
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                    ),
                    child: Icon(
                      isEarned ? Icons.add_circle : Icons.remove_circle,
                      color: isEarned ? AppColors.success : AppColors.error,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['description'] as String,
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          Formatters.date(
                            item['date'] as DateTime,
                            format: 'MMM dd, yyyy',
                          ),
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${isEarned ? '+' : ''}${item['points']}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: isEarned ? AppColors.success : AppColors.error,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
