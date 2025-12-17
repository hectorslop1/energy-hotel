import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';

class BillingScreen extends ConsumerStatefulWidget {
  const BillingScreen({super.key});

  @override
  ConsumerState<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends ConsumerState<BillingScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _charges = [
    {
      'id': 'c1',
      'description': 'Room Charge - Ocean View Suite',
      'category': 'Accommodation',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'amount': 299.0,
      'icon': Icons.hotel,
    },
    {
      'id': 'c2',
      'description': 'Room Charge - Ocean View Suite',
      'category': 'Accommodation',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'amount': 299.0,
      'icon': Icons.hotel,
    },
    {
      'id': 'c3',
      'description': 'La Terraza - Dinner',
      'category': 'Dining',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'amount': 156.50,
      'icon': Icons.restaurant,
    },
    {
      'id': 'c4',
      'description': 'Swedish Massage - 60 min',
      'category': 'Spa',
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'amount': 120.0,
      'icon': Icons.spa,
    },
    {
      'id': 'c5',
      'description': 'Room Service - Breakfast',
      'category': 'Dining',
      'date': DateTime.now(),
      'amount': 45.0,
      'icon': Icons.room_service,
    },
    {
      'id': 'c6',
      'description': 'Minibar',
      'category': 'Minibar',
      'date': DateTime.now().subtract(const Duration(hours: 12)),
      'amount': 28.0,
      'icon': Icons.liquor,
    },
    {
      'id': 'c7',
      'description': 'Pool Cabana - Half Day',
      'category': 'Activities',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'amount': 150.0,
      'icon': Icons.pool,
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'card1',
      'type': 'visa',
      'last4': '4242',
      'expiry': '12/26',
      'isDefault': true,
    },
    {
      'id': 'card2',
      'type': 'mastercard',
      'last4': '8888',
      'expiry': '09/25',
      'isDefault': false,
    },
  ];

  double get _totalCharges =>
      _charges.fold(0, (sum, c) => sum + (c['amount'] as double));

  Map<String, double> get _chargesByCategory {
    final map = <String, double>{};
    for (final charge in _charges) {
      final category = charge['category'] as String;
      map[category] = (map[category] ?? 0) + (charge['amount'] as double);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Billing & Wallet'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildBalanceCard(),
          _buildTabs(),
          Expanded(
            child: _selectedTab == 0
                ? _buildChargesList()
                : _buildPaymentMethods(),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Balance',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(
                    AppSpacing.borderRadiusXl,
                  ),
                ),
                child: Text(
                  'Room 412',
                  style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            Formatters.currency(_totalCharges),
            style: AppTextStyles.displayMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(child: _buildCategorySummary()),
              const SizedBox(width: AppSpacing.md),
              ElevatedButton.icon(
                onPressed: _showPaymentSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                  ),
                ),
                icon: const Icon(Icons.payment, size: 18),
                label: const Text('Pay Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySummary() {
    final topCategories = _chargesByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top3 = topCategories.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Charges',
          style: AppTextStyles.caption.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        ...top3.map(
          (e) => Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(e.key),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${e.key}: ${Formatters.currency(e.value)}',
                  style: AppTextStyles.caption.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Accommodation':
        return Colors.blue;
      case 'Dining':
        return Colors.orange;
      case 'Spa':
        return Colors.purple;
      case 'Activities':
        return Colors.green;
      case 'Minibar':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _selectedTab == 0
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Text(
                  'Charges',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: _selectedTab == 0
                        ? Colors.white
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _selectedTab == 1
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Text(
                  'Payment Methods',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: _selectedTab == 1
                        ? Colors.white
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChargesList() {
    final groupedCharges = <String, List<Map<String, dynamic>>>{};
    for (final charge in _charges) {
      final date = charge['date'] as DateTime;
      final key = _getDateKey(date);
      groupedCharges.putIfAbsent(key, () => []);
      groupedCharges[key]!.add(charge);
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: groupedCharges.entries
          .expand(
            (entry) => [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.md,
                  bottom: AppSpacing.sm,
                ),
                child: Text(
                  entry.key,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              ...entry.value.map((charge) => _buildChargeCard(charge)),
            ],
          )
          .toList(),
    );
  }

  String _getDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final chargeDate = DateTime(date.year, date.month, date.day);

    if (chargeDate == today) return 'Today';
    if (chargeDate == yesterday) return 'Yesterday';
    return Formatters.date(date, format: 'EEEE, MMM dd');
  }

  Widget _buildChargeCard(Map<String, dynamic> charge) {
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
              color: _getCategoryColor(
                charge['category'] as String,
              ).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Icon(
              charge['icon'] as IconData,
              color: _getCategoryColor(charge['category'] as String),
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  charge['description'] as String,
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  charge['category'] as String,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Text(
            Formatters.currency(charge['amount'] as double),
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.accent),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        ..._paymentMethods.map((method) => _buildPaymentMethodCard(method)),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(AppSpacing.md),
            side: BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Add Payment Method'),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final isVisa = method['type'] == 'visa';
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        border: Border.all(
          color: method['isDefault'] == true
              ? AppColors.primary
              : AppColors.border,
          width: method['isDefault'] == true ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 35,
            decoration: BoxDecoration(
              color: isVisa ? const Color(0xFF1A1F71) : const Color(0xFFEB001B),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                isVisa ? 'VISA' : 'MC',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '•••• •••• •••• ${method['last4']}',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Expires ${method['expiry']}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          if (method['isDefault'] == true)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryWithOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
              ),
              child: Text(
                'Default',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PaymentSheet(
        totalAmount: _totalCharges,
        paymentMethods: _paymentMethods,
      ),
    );
  }
}

class _PaymentSheet extends StatefulWidget {
  final double totalAmount;
  final List<Map<String, dynamic>> paymentMethods;

  const _PaymentSheet({
    required this.totalAmount,
    required this.paymentMethods,
  });

  @override
  State<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<_PaymentSheet> {
  String? _selectedMethod;
  bool _isProcessing = false;
  double _tipPercentage = 0;

  @override
  void initState() {
    super.initState();
    _selectedMethod =
        widget.paymentMethods.firstWhere(
              (m) => m['isDefault'] == true,
              orElse: () => widget.paymentMethods.first,
            )['id']
            as String;
  }

  double get _tipAmount => widget.totalAmount * _tipPercentage / 100;
  double get _grandTotal => widget.totalAmount + _tipAmount;

  Future<void> _processPayment() async {
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
              Text('Payment Successful!', style: AppTextStyles.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your payment of ${Formatters.currency(_grandTotal)} has been processed.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
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
            Text('Pay Your Bill', style: AppTextStyles.headlineMedium),
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
                      Text('Subtotal', style: AppTextStyles.bodyMedium),
                      Text(
                        Formatters.currency(widget.totalAmount),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip', style: AppTextStyles.bodyMedium),
                      Text(
                        Formatters.currency(_tipAmount),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.titleMedium),
                      Text(
                        Formatters.currency(_grandTotal),
                        style: AppTextStyles.headlineSmall.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Add a Tip', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [0, 10, 15, 20].map((tip) {
                final isSelected = _tipPercentage == tip;
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _tipPercentage = tip.toDouble()),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: tip < 20 ? AppSpacing.sm : 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.surface,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.borderRadius,
                        ),
                      ),
                      child: Text(
                        tip == 0 ? 'None' : '$tip%',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Payment Method', style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            ...widget.paymentMethods.map((method) {
              final isSelected = _selectedMethod == method['id'];
              final isVisa = method['type'] == 'visa';
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedMethod = method['id'] as String),
                child: Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryWithOpacity(0.05)
                        : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
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
                      Container(
                        width: 40,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isVisa
                              ? const Color(0xFF1A1F71)
                              : const Color(0xFFEB001B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            isVisa ? 'VISA' : 'MC',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '•••• ${method['last4']}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              text: _isProcessing
                  ? 'Processing...'
                  : 'Pay ${Formatters.currency(_grandTotal)}',
              isLoading: _isProcessing,
              onPressed: _isProcessing ? null : _processPayment,
            ),
          ],
        ),
      ),
    );
  }
}
