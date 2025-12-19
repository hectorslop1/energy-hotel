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

class RoomServiceSheet extends ConsumerStatefulWidget {
  const RoomServiceSheet({super.key});

  @override
  ConsumerState<RoomServiceSheet> createState() => _RoomServiceSheetState();
}

class _RoomServiceSheetState extends ConsumerState<RoomServiceSheet> {
  int _currentStep = 0;
  String _selectedMealTime = 'anytime';
  final Map<String, int> _cartItems = {};
  final Map<String, List<String>> _itemCustomizations = {};
  final TextEditingController _deliveryInstructionsController =
      TextEditingController();
  bool _isProcessing = false;

  List<Map<String, dynamic>> get _mealTimes {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'id': 'breakfast',
        'name': l10n.breakfast,
        'icon': Icons.free_breakfast,
        'hours': '6:00 AM - 11:00 AM',
      },
      {
        'id': 'lunch',
        'name': l10n.lunch,
        'icon': Icons.lunch_dining,
        'hours': '11:00 AM - 4:00 PM',
      },
      {
        'id': 'dinner',
        'name': l10n.dinner,
        'icon': Icons.dinner_dining,
        'hours': '5:00 PM - 11:00 PM',
      },
      {
        'id': 'anytime',
        'name': l10n.all,
        'icon': Icons.schedule,
        'hours': '24 hours',
      },
    ];
  }

  List<Map<String, dynamic>> get _menu {
    switch (_selectedMealTime) {
      case 'breakfast':
        return [
          {
            'id': 'continental',
            'name': 'Continental Breakfast',
            'description':
                'Croissants, pastries, fresh fruit, yogurt, coffee/tea',
            'price': 24.0,
            'category': 'Breakfast Sets',
            'customizations': [
              'No dairy',
              'Gluten-free bread',
              'Decaf coffee',
              'Almond milk',
            ],
          },
          {
            'id': 'american',
            'name': 'American Breakfast',
            'description': 'Eggs any style, bacon, sausage, hash browns, toast',
            'price': 28.0,
            'category': 'Breakfast Sets',
            'customizations': [
              'Scrambled',
              'Sunny side up',
              'Over easy',
              'Poached',
              'No bacon',
              'Turkey bacon',
              'No hash browns',
              'Egg whites only',
            ],
          },
          {
            'id': 'healthy',
            'name': 'Healthy Start',
            'description':
                'Avocado toast, poached eggs, fresh greens, smoothie',
            'price': 26.0,
            'category': 'Breakfast Sets',
            'customizations': [
              'No eggs',
              'Extra avocado',
              'Gluten-free bread',
              'No smoothie',
            ],
          },
          {
            'id': 'pancakes',
            'name': 'Buttermilk Pancakes',
            'description': 'Stack of 3 with maple syrup and butter',
            'price': 18.0,
            'category': 'Classics',
            'customizations': [
              'Add blueberries',
              'Add chocolate chips',
              'Add banana',
              'Whipped cream',
              'Sugar-free syrup',
            ],
          },
          {
            'id': 'french_toast',
            'name': 'French Toast',
            'description': 'Brioche bread with cinnamon and vanilla',
            'price': 20.0,
            'category': 'Classics',
            'customizations': [
              'Add berries',
              'Add bacon',
              'No powdered sugar',
              'Extra cinnamon',
            ],
          },
          {
            'id': 'omelette',
            'name': 'Build Your Omelette',
            'description': '3-egg omelette with choice of fillings',
            'price': 22.0,
            'category': 'Eggs',
            'customizations': [
              'Cheese',
              'Ham',
              'Mushrooms',
              'Peppers',
              'Onions',
              'Tomatoes',
              'Spinach',
              'Egg whites only',
            ],
          },
          {
            'id': 'eggs_benedict',
            'name': 'Eggs Benedict',
            'description': 'Poached eggs, Canadian bacon, hollandaise',
            'price': 24.0,
            'category': 'Eggs',
            'customizations': [
              'Smoked salmon instead',
              'Spinach instead',
              'No hollandaise',
              'Extra hollandaise',
            ],
          },
          {
            'id': 'fresh_juice',
            'name': 'Fresh Squeezed Juice',
            'description': 'Orange, grapefruit, or apple',
            'price': 8.0,
            'category': 'Beverages',
            'customizations': ['Orange', 'Grapefruit', 'Apple', 'Mixed'],
          },
          {
            'id': 'smoothie',
            'name': 'Fresh Smoothie',
            'description': 'Tropical, berry, or green',
            'price': 12.0,
            'category': 'Beverages',
            'customizations': [
              'Tropical',
              'Berry',
              'Green',
              'Add protein',
              'No banana',
            ],
          },
        ];
      case 'lunch':
        return [
          {
            'id': 'club_sandwich',
            'name': 'Club Sandwich',
            'description': 'Triple-decker with turkey, bacon, lettuce, tomato',
            'price': 22.0,
            'category': 'Sandwiches',
            'customizations': [
              'No bacon',
              'No tomato',
              'Gluten-free bread',
              'Add avocado',
              'Extra mayo',
            ],
          },
          {
            'id': 'burger',
            'name': 'Gourmet Burger',
            'description':
                'Angus beef, cheddar, caramelized onions, special sauce',
            'price': 26.0,
            'category': 'Sandwiches',
            'customizations': [
              'Medium',
              'Well done',
              'No cheese',
              'No onions',
              'Add bacon',
              'Add egg',
              'Lettuce wrap',
            ],
          },
          {
            'id': 'caesar_salad',
            'name': 'Caesar Salad',
            'description': 'Romaine, parmesan, croutons, classic dressing',
            'price': 18.0,
            'category': 'Salads',
            'customizations': [
              'Add chicken',
              'Add shrimp',
              'No croutons',
              'No anchovies',
              'Dressing on side',
            ],
          },
          {
            'id': 'cobb_salad',
            'name': 'Cobb Salad',
            'description': 'Chicken, bacon, egg, avocado, blue cheese',
            'price': 24.0,
            'category': 'Salads',
            'customizations': [
              'No bacon',
              'No egg',
              'No blue cheese',
              'Ranch dressing',
              'Vinaigrette',
            ],
          },
          {
            'id': 'pasta',
            'name': 'Pasta of the Day',
            'description': 'Ask about today\'s special pasta',
            'price': 24.0,
            'category': 'Main Courses',
            'customizations': [
              'Gluten-free pasta',
              'Extra parmesan',
              'No garlic',
              'Spicy',
            ],
          },
          {
            'id': 'fish_chips',
            'name': 'Fish & Chips',
            'description': 'Beer-battered cod with tartar sauce',
            'price': 26.0,
            'category': 'Main Courses',
            'customizations': [
              'Extra crispy',
              'Grilled instead',
              'No tartar',
              'Malt vinegar',
            ],
          },
          {
            'id': 'soup',
            'name': 'Soup of the Day',
            'description': 'Fresh made daily',
            'price': 12.0,
            'category': 'Starters',
            'customizations': ['No cream', 'Extra bread', 'Large size'],
          },
        ];
      case 'dinner':
        return [
          {
            'id': 'steak',
            'name': 'Grilled Ribeye',
            'description': '12oz USDA Prime with herb butter',
            'price': 52.0,
            'category': 'Steaks',
            'customizations': [
              'Rare',
              'Medium rare',
              'Medium',
              'Medium well',
              'Well done',
              'No butter',
              'Peppercorn sauce',
            ],
          },
          {
            'id': 'filet',
            'name': 'Filet Mignon',
            'description': '8oz center-cut tenderloin',
            'price': 48.0,
            'category': 'Steaks',
            'customizations': [
              'Rare',
              'Medium rare',
              'Medium',
              'Medium well',
              'Blue cheese crust',
              'Béarnaise sauce',
            ],
          },
          {
            'id': 'salmon',
            'name': 'Atlantic Salmon',
            'description': 'Pan-seared with lemon dill sauce',
            'price': 38.0,
            'category': 'Seafood',
            'customizations': [
              'No sauce',
              'Extra lemon',
              'Grilled',
              'Blackened',
              'Teriyaki glaze',
            ],
          },
          {
            'id': 'lobster',
            'name': 'Lobster Tail',
            'description': 'Butter-poached Maine lobster',
            'price': 58.0,
            'category': 'Seafood',
            'customizations': [
              'Grilled',
              'Extra butter',
              'Garlic butter',
              'No sides',
            ],
          },
          {
            'id': 'chicken',
            'name': 'Roasted Chicken',
            'description': 'Half chicken with herbs and jus',
            'price': 32.0,
            'category': 'Poultry',
            'customizations': [
              'Breast only',
              'Dark meat only',
              'Extra crispy skin',
              'No jus',
            ],
          },
          {
            'id': 'risotto',
            'name': 'Mushroom Risotto',
            'description': 'Arborio rice with wild mushrooms and truffle',
            'price': 28.0,
            'category': 'Vegetarian',
            'customizations': [
              'No truffle',
              'Extra parmesan',
              'Vegan (no cheese)',
              'Add chicken',
            ],
          },
          {
            'id': 'cheesecake',
            'name': 'NY Cheesecake',
            'description': 'Classic with berry compote',
            'price': 14.0,
            'category': 'Desserts',
            'customizations': [
              'No berries',
              'Chocolate sauce',
              'Caramel sauce',
              'Extra whipped cream',
            ],
          },
          {
            'id': 'chocolate_cake',
            'name': 'Chocolate Lava Cake',
            'description': 'Warm with vanilla ice cream',
            'price': 16.0,
            'category': 'Desserts',
            'customizations': [
              'No ice cream',
              'Extra chocolate',
              'Raspberry sauce',
            ],
          },
        ];
      case 'anytime':
        return [
          {
            'id': 'fries',
            'name': 'Truffle Fries',
            'description': 'With parmesan and truffle aioli',
            'price': 14.0,
            'category': 'Snacks',
            'customizations': [
              'No truffle',
              'Extra crispy',
              'Ketchup',
              'Ranch',
            ],
          },
          {
            'id': 'wings',
            'name': 'Chicken Wings',
            'description': 'Buffalo, BBQ, or garlic parmesan (10 pcs)',
            'price': 18.0,
            'category': 'Snacks',
            'customizations': [
              'Buffalo',
              'BBQ',
              'Garlic parmesan',
              'Extra sauce',
              'Blue cheese dip',
              'Ranch dip',
            ],
          },
          {
            'id': 'nachos',
            'name': 'Loaded Nachos',
            'description': 'Cheese, jalapeños, sour cream, guacamole',
            'price': 16.0,
            'category': 'Snacks',
            'customizations': [
              'No jalapeños',
              'Extra cheese',
              'Add chicken',
              'Add beef',
              'No sour cream',
            ],
          },
          {
            'id': 'pizza',
            'name': 'Personal Pizza',
            'description': 'Margherita, pepperoni, or veggie',
            'price': 20.0,
            'category': 'Snacks',
            'customizations': [
              'Margherita',
              'Pepperoni',
              'Veggie',
              'Extra cheese',
              'Gluten-free crust',
            ],
          },
          {
            'id': 'ice_cream',
            'name': 'Ice Cream Sundae',
            'description': 'Three scoops with toppings',
            'price': 12.0,
            'category': 'Desserts',
            'customizations': [
              'Vanilla',
              'Chocolate',
              'Strawberry',
              'Hot fudge',
              'Caramel',
              'Whipped cream',
              'No nuts',
            ],
          },
          {
            'id': 'fruit_plate',
            'name': 'Fresh Fruit Plate',
            'description': 'Seasonal selection',
            'price': 14.0,
            'category': 'Healthy',
            'customizations': [
              'No melon',
              'Extra berries',
              'Add yogurt',
              'Add honey',
            ],
          },
          {
            'id': 'cheese_plate',
            'name': 'Artisan Cheese Plate',
            'description': 'Selection of cheeses with crackers',
            'price': 22.0,
            'category': 'Snacks',
            'customizations': [
              'No blue cheese',
              'Extra crackers',
              'Add honey',
              'Add nuts',
            ],
          },
          {
            'id': 'coffee',
            'name': 'Coffee / Tea',
            'description': 'Regular, decaf, or selection of teas',
            'price': 6.0,
            'category': 'Beverages',
            'customizations': [
              'Regular coffee',
              'Decaf',
              'Espresso',
              'Cappuccino',
              'Green tea',
              'Black tea',
              'Herbal tea',
            ],
          },
          {
            'id': 'soft_drinks',
            'name': 'Soft Drinks',
            'description': 'Coke, Sprite, or sparkling water',
            'price': 5.0,
            'category': 'Beverages',
            'customizations': [
              'Coke',
              'Diet Coke',
              'Sprite',
              'Sparkling water',
              'Still water',
            ],
          },
        ];
      default:
        return [];
    }
  }

  double get _subtotal {
    double total = 0;
    for (final entry in _cartItems.entries) {
      final item = _findItemById(entry.key);
      if (item != null) {
        total += (item['price'] as double) * entry.value;
      }
    }
    return total;
  }

  double get _deliveryFee => _subtotal > 50 ? 0 : 5.0;
  double get _total => _subtotal + _deliveryFee;

  Map<String, dynamic>? _findItemById(String id) {
    for (final mealTime in ['breakfast', 'lunch', 'dinner', 'anytime']) {
      final oldMealTime = _selectedMealTime;
      _selectedMealTime = mealTime;
      final items = _menu;
      _selectedMealTime = oldMealTime;
      final item = items.where((i) => i['id'] == id).firstOrNull;
      if (item != null) return item;
    }
    return null;
  }

  void _addToCart(String itemId) {
    setState(() {
      _cartItems[itemId] = (_cartItems[itemId] ?? 0) + 1;
    });
  }

  void _removeFromCart(String itemId) {
    setState(() {
      if (_cartItems[itemId] != null && _cartItems[itemId]! > 1) {
        _cartItems[itemId] = _cartItems[itemId]! - 1;
      } else {
        _cartItems.remove(itemId);
        _itemCustomizations.remove(itemId);
      }
    });
  }

  void _toggleCustomization(String itemId, String customization) {
    setState(() {
      if (!_itemCustomizations.containsKey(itemId)) {
        _itemCustomizations[itemId] = [];
      }
      if (_itemCustomizations[itemId]!.contains(customization)) {
        _itemCustomizations[itemId]!.remove(customization);
      } else {
        _itemCustomizations[itemId]!.add(customization);
      }
    });
  }

  Future<void> _processOrder() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    final itemNames = _cartItems.keys
        .map((id) {
          final item = _findItemById(id);
          return item?['name'] ?? 'Item';
        })
        .take(2)
        .join(', ');
    final moreItems = _cartItems.length > 2
        ? ' +${_cartItems.length - 2} more'
        : '';

    final reservation = Reservation(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Room Service: $itemNames$moreItems',
      imageUrl:
          'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=400',
      type: ReservationType.service,
      status: ReservationStatus.upcoming,
      date: DateTime.now(),
      time: 'ASAP (~30 min)',
      guestCount: 1,
      price: _total,
      category: 'Room Service',
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
                  Icons.room_service,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                AppLocalizations.of(context)!.orderConfirmed,
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                AppLocalizations.of(context)!.preparingOrder,
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
                    _buildInfoRow(Icons.receipt, '${_cartItems.length} items'),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(Icons.access_time, 'Estimated: 25-35 min'),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      Icons.attach_money,
                      Formatters.currency(_total),
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
            if (_currentStep == 0) _buildMealTimeSelector(),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppDurations.normal,
                child: _currentStep == 0 ? _buildMenuList() : _buildCart(),
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
                child: const Icon(Icons.room_service, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.roomService,
                      style: AppTextStyles.headlineMedium,
                    ),
                    Text(
                      _currentStep == 0
                          ? AppLocalizations.of(context)!.orderFoodToYourRoom
                          : AppLocalizations.of(context)!.reviewOrder,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              if (_cartItems.isNotEmpty && _currentStep == 0)
                GestureDetector(
                  onTap: () => setState(() => _currentStep = 1),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${_cartItems.values.fold(0, (a, b) => a + b)}',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealTimeSelector() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: _mealTimes.length,
        itemBuilder: (context, index) {
          final mealTime = _mealTimes[index];
          final isSelected = _selectedMealTime == mealTime['id'];
          return GestureDetector(
            onTap: () =>
                setState(() => _selectedMealTime = mealTime['id'] as String),
            child: AnimatedContainer(
              duration: AppDurations.fast,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadiusXl),
              ),
              child: Row(
                children: [
                  Icon(
                    mealTime['icon'] as IconData,
                    size: 18,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    mealTime['name'] as String,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuList() {
    final groupedMenu = <String, List<Map<String, dynamic>>>{};
    for (final item in _menu) {
      final category = item['category'] as String;
      groupedMenu.putIfAbsent(category, () => []);
      groupedMenu[category]!.add(item);
    }

    return ListView(
      key: ValueKey('menu_$_selectedMealTime'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        ...groupedMenu.entries.expand(
          (entry) => [
            Text(entry.key, style: AppTextStyles.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            ...entry.value.map((item) => _buildMenuItem(item)),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    final quantity = _cartItems[item['id']] ?? 0;
    final customizations = _itemCustomizations[item['id']] ?? [];

    return AnimatedContainer(
      duration: AppDurations.fast,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: quantity > 0
            ? AppColors.primaryWithOpacity(0.05)
            : AppColors.surface,
        border: Border.all(
          color: quantity > 0 ? AppColors.primary : AppColors.border,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        children: [
          Padding(
            padding: AppSpacing.cardPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] as String,
                        style: AppTextStyles.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['description'] as String,
                        style: AppTextStyles.caption,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        Formatters.currency(item['price'] as double),
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                if (quantity == 0)
                  GestureDetector(
                    onTap: () => _addToCart(item['id'] as String),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.borderRadius,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              _removeFromCart(item['id'] as String),
                          icon: const Icon(Icons.remove, size: 18),
                          color: AppColors.primary,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        Text('$quantity', style: AppTextStyles.titleSmall),
                        IconButton(
                          onPressed: () => _addToCart(item['id'] as String),
                          icon: const Icon(Icons.add, size: 18),
                          color: AppColors.primary,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (quantity > 0) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.customize,
                    style: AppTextStyles.labelSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: (item['customizations'] as List<String>).map((c) {
                      final isSelected = customizations.contains(c);
                      return GestureDetector(
                        onTap: () =>
                            _toggleCustomization(item['id'] as String, c),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.borderRadiusXl,
                            ),
                          ),
                          child: Text(
                            c,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCart() {
    return SingleChildScrollView(
      key: const ValueKey('cart'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.orderSummary,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          ..._cartItems.entries.map((entry) {
            final item = _findItemById(entry.key);
            if (item == null) return const SizedBox();
            final customizations = _itemCustomizations[entry.key] ?? [];
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${entry.value}x',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
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
                          item['name'] as String,
                          style: AppTextStyles.bodyMedium,
                        ),
                        if (customizations.isNotEmpty)
                          Text(
                            customizations.join(', '),
                            style: AppTextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  Text(
                    Formatters.currency(
                      (item['price'] as double) * entry.value,
                    ),
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppLocalizations.of(context)!.deliveryInstructions,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Leave at door, call upon arrival, etc.',
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
            controller: _deliveryInstructionsController,
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
                      AppLocalizations.of(context)!.subtotal,
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      Formatters.currency(_subtotal),
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.deliveryFee,
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      _deliveryFee == 0
                          ? 'FREE'
                          : Formatters.currency(_deliveryFee),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _deliveryFee == 0 ? AppColors.success : null,
                      ),
                    ),
                  ],
                ),
                if (_deliveryFee > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Free delivery on orders over \$50',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                const Divider(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.total,
                      style: AppTextStyles.titleMedium,
                    ),
                    Text(
                      Formatters.currency(_total),
                      style: AppTextStyles.headlineSmall.copyWith(
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
      child: Row(
        children: [
          if (_cartItems.isNotEmpty) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_cartItems.values.fold(0, (a, b) => a + b)} items',
                    style: AppTextStyles.caption,
                  ),
                  Text(
                    Formatters.currency(_total),
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            flex: _cartItems.isNotEmpty ? 2 : 1,
            child: PrimaryButton(
              text: _currentStep == 0
                  ? (_cartItems.isEmpty
                        ? AppLocalizations.of(context)!.addItemsToOrder
                        : AppLocalizations.of(context)!.viewCart)
                  : (_isProcessing
                        ? AppLocalizations.of(context)!.placingOrder
                        : AppLocalizations.of(context)!.placeOrder),
              isLoading: _isProcessing,
              onPressed: _cartItems.isEmpty
                  ? null
                  : () {
                      if (_currentStep == 0) {
                        setState(() => _currentStep = 1);
                      } else {
                        _processOrder();
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
