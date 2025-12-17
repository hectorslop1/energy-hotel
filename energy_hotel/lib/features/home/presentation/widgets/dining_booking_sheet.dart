import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../profile/domain/entities/reservation.dart';
import '../../../profile/presentation/providers/reservations_provider.dart';

class DiningBookingSheet extends ConsumerStatefulWidget {
  const DiningBookingSheet({super.key});

  @override
  ConsumerState<DiningBookingSheet> createState() => _DiningBookingSheetState();
}

class _DiningBookingSheetState extends ConsumerState<DiningBookingSheet> {
  int _currentStep = 0;
  Map<String, dynamic>? _selectedRestaurant;
  final List<Map<String, dynamic>> _selectedDishes = [];
  final Map<String, List<String>> _dishCustomizations = {};
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '7:00 PM';
  int _guestCount = 2;
  String _specialRequests = '';
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _restaurants = [
    {
      'id': 'la_terraza',
      'name': 'La Terraza',
      'cuisine': 'Mediterranean',
      'rating': 4.8,
      'priceRange': '\$\$\$',
      'image':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
      'description': 'Rooftop dining with ocean views',
      'hours': '6:00 PM - 11:00 PM',
    },
    {
      'id': 'sakura',
      'name': 'Sakura',
      'cuisine': 'Japanese',
      'rating': 4.9,
      'priceRange': '\$\$\$\$',
      'image':
          'https://images.unsplash.com/photo-1579027989536-b7b1f875659b?w=400',
      'description': 'Authentic Japanese cuisine & sushi bar',
      'hours': '12:00 PM - 10:00 PM',
    },
    {
      'id': 'el_jardin',
      'name': 'El Jardín',
      'cuisine': 'Mexican',
      'rating': 4.7,
      'priceRange': '\$\$',
      'image':
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
      'description': 'Traditional Mexican flavors',
      'hours': '7:00 AM - 10:00 PM',
    },
    {
      'id': 'the_grill',
      'name': 'The Grill House',
      'cuisine': 'Steakhouse',
      'rating': 4.6,
      'priceRange': '\$\$\$\$',
      'image':
          'https://images.unsplash.com/photo-1544025162-d76694265947?w=400',
      'description': 'Premium cuts & fine wines',
      'hours': '5:00 PM - 11:00 PM',
    },
    {
      'id': 'pool_bar',
      'name': 'Pool Bar & Grill',
      'cuisine': 'Casual',
      'rating': 4.5,
      'priceRange': '\$\$',
      'image':
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400',
      'description': 'Casual poolside dining',
      'hours': '10:00 AM - 8:00 PM',
    },
  ];

  List<Map<String, dynamic>> get _menu {
    switch (_selectedRestaurant?['id']) {
      case 'la_terraza':
        return [
          {
            'id': 'bruschetta',
            'name': 'Bruschetta Trio',
            'description': 'Tomato, olive tapenade, and ricotta',
            'price': 16.0,
            'category': 'Starters',
            'customizations': ['No garlic', 'Extra basil', 'Gluten-free bread'],
          },
          {
            'id': 'calamari',
            'name': 'Crispy Calamari',
            'description': 'With lemon aioli and marinara',
            'price': 18.0,
            'category': 'Starters',
            'customizations': ['Extra crispy', 'No sauce', 'Spicy aioli'],
          },
          {
            'id': 'sea_bass',
            'name': 'Mediterranean Sea Bass',
            'description': 'Grilled with herbs, capers, and lemon',
            'price': 42.0,
            'category': 'Main Course',
            'customizations': [
              'No capers',
              'Extra lemon',
              'Well done',
              'Medium',
            ],
          },
          {
            'id': 'risotto',
            'name': 'Truffle Risotto',
            'description': 'Arborio rice with black truffle and parmesan',
            'price': 38.0,
            'category': 'Main Course',
            'customizations': ['No truffle', 'Extra parmesan', 'Vegan option'],
          },
          {
            'id': 'lamb',
            'name': 'Herb-Crusted Lamb',
            'description': 'With roasted vegetables and mint jus',
            'price': 48.0,
            'category': 'Main Course',
            'customizations': ['Medium rare', 'Medium', 'Well done', 'No mint'],
          },
          {
            'id': 'tiramisu',
            'name': 'Classic Tiramisu',
            'description': 'Espresso-soaked ladyfingers with mascarpone',
            'price': 14.0,
            'category': 'Desserts',
            'customizations': ['No alcohol', 'Extra cocoa', 'Decaf'],
          },
        ];
      case 'sakura':
        return [
          {
            'id': 'edamame',
            'name': 'Edamame',
            'description': 'Steamed soybeans with sea salt',
            'price': 8.0,
            'category': 'Starters',
            'customizations': ['Spicy', 'Garlic', 'No salt'],
          },
          {
            'id': 'sashimi',
            'name': 'Sashimi Platter',
            'description': 'Chef\'s selection of fresh fish',
            'price': 36.0,
            'category': 'Sashimi',
            'customizations': ['No salmon', 'Extra tuna', 'Wasabi on side'],
          },
          {
            'id': 'dragon_roll',
            'name': 'Dragon Roll',
            'description': 'Eel, avocado, cucumber with unagi sauce',
            'price': 22.0,
            'category': 'Rolls',
            'customizations': [
              'No eel',
              'Extra avocado',
              'Spicy mayo',
              'No sauce',
            ],
          },
          {
            'id': 'rainbow_roll',
            'name': 'Rainbow Roll',
            'description': 'California roll topped with assorted fish',
            'price': 24.0,
            'category': 'Rolls',
            'customizations': ['No crab', 'Extra fish', 'Brown rice'],
          },
          {
            'id': 'wagyu',
            'name': 'A5 Wagyu Steak',
            'description': 'Premium Japanese beef with truffle salt',
            'price': 85.0,
            'category': 'Main Course',
            'customizations': ['Rare', 'Medium rare', 'Medium', 'No truffle'],
          },
          {
            'id': 'mochi',
            'name': 'Mochi Ice Cream',
            'description': 'Assorted flavors (3 pieces)',
            'price': 10.0,
            'category': 'Desserts',
            'customizations': [
              'Green tea only',
              'Strawberry only',
              'Mango only',
            ],
          },
        ];
      case 'el_jardin':
        return [
          {
            'id': 'guacamole',
            'name': 'Fresh Guacamole',
            'description': 'Made tableside with chips',
            'price': 14.0,
            'category': 'Starters',
            'customizations': [
              'Extra spicy',
              'No cilantro',
              'No onion',
              'Extra lime',
            ],
          },
          {
            'id': 'tacos',
            'name': 'Street Tacos (3)',
            'description': 'Choice of carnitas, chicken, or fish',
            'price': 18.0,
            'category': 'Main Course',
            'customizations': [
              'Carnitas',
              'Chicken',
              'Fish',
              'No cilantro',
              'Extra salsa',
            ],
          },
          {
            'id': 'enchiladas',
            'name': 'Enchiladas Suizas',
            'description': 'Chicken enchiladas with green tomatillo sauce',
            'price': 22.0,
            'category': 'Main Course',
            'customizations': [
              'No cheese',
              'Extra sauce',
              'Beef instead',
              'Spicy',
            ],
          },
          {
            'id': 'mole',
            'name': 'Chicken Mole',
            'description': 'Traditional Oaxacan mole with rice',
            'price': 26.0,
            'category': 'Main Course',
            'customizations': ['No sesame', 'Extra rice', 'Mild'],
          },
          {
            'id': 'churros',
            'name': 'Churros con Chocolate',
            'description': 'Cinnamon sugar churros with chocolate sauce',
            'price': 12.0,
            'category': 'Desserts',
            'customizations': [
              'No cinnamon',
              'Extra chocolate',
              'Caramel sauce',
            ],
          },
        ];
      case 'the_grill':
        return [
          {
            'id': 'oysters',
            'name': 'Fresh Oysters (6)',
            'description': 'With mignonette and cocktail sauce',
            'price': 24.0,
            'category': 'Starters',
            'customizations': ['No mignonette', 'Extra lemon', 'Dozen instead'],
          },
          {
            'id': 'caesar',
            'name': 'Classic Caesar',
            'description': 'Romaine, parmesan, croutons, anchovy dressing',
            'price': 16.0,
            'category': 'Starters',
            'customizations': [
              'No anchovies',
              'No croutons',
              'Add chicken',
              'Add shrimp',
            ],
          },
          {
            'id': 'ribeye',
            'name': 'Prime Ribeye (16oz)',
            'description': 'USDA Prime with herb butter',
            'price': 68.0,
            'category': 'Steaks',
            'customizations': [
              'Rare',
              'Medium rare',
              'Medium',
              'Medium well',
              'Well done',
              'No butter',
            ],
          },
          {
            'id': 'filet',
            'name': 'Filet Mignon (8oz)',
            'description': 'Center-cut tenderloin',
            'price': 58.0,
            'category': 'Steaks',
            'customizations': [
              'Rare',
              'Medium rare',
              'Medium',
              'Medium well',
              'Blue cheese crust',
            ],
          },
          {
            'id': 'lobster',
            'name': 'Maine Lobster Tail',
            'description': 'Butter-poached with drawn butter',
            'price': 65.0,
            'category': 'Seafood',
            'customizations': [
              'Grilled instead',
              'Extra butter',
              'Garlic butter',
            ],
          },
          {
            'id': 'cheesecake',
            'name': 'NY Cheesecake',
            'description': 'With berry compote',
            'price': 14.0,
            'category': 'Desserts',
            'customizations': [
              'No berries',
              'Chocolate sauce',
              'Caramel sauce',
            ],
          },
        ];
      case 'pool_bar':
        return [
          {
            'id': 'nachos',
            'name': 'Loaded Nachos',
            'description': 'Cheese, jalapeños, sour cream, guacamole',
            'price': 16.0,
            'category': 'Starters',
            'customizations': [
              'No jalapeños',
              'Extra cheese',
              'Add chicken',
              'Add beef',
            ],
          },
          {
            'id': 'wings',
            'name': 'Chicken Wings',
            'description': 'Buffalo, BBQ, or garlic parmesan',
            'price': 18.0,
            'category': 'Starters',
            'customizations': [
              'Buffalo',
              'BBQ',
              'Garlic parmesan',
              'Extra crispy',
            ],
          },
          {
            'id': 'burger',
            'name': 'Pool Bar Burger',
            'description': 'Angus beef, cheddar, bacon, special sauce',
            'price': 22.0,
            'category': 'Main Course',
            'customizations': [
              'No bacon',
              'No cheese',
              'Add avocado',
              'Add egg',
              'Medium',
              'Well done',
            ],
          },
          {
            'id': 'fish_tacos',
            'name': 'Fish Tacos',
            'description': 'Grilled mahi-mahi with mango salsa',
            'price': 20.0,
            'category': 'Main Course',
            'customizations': [
              'Fried instead',
              'No salsa',
              'Extra spicy',
              'Shrimp instead',
            ],
          },
          {
            'id': 'sundae',
            'name': 'Ice Cream Sundae',
            'description': 'Vanilla, chocolate, or strawberry',
            'price': 10.0,
            'category': 'Desserts',
            'customizations': [
              'Vanilla',
              'Chocolate',
              'Strawberry',
              'No whipped cream',
              'Extra toppings',
            ],
          },
        ];
      default:
        return [];
    }
  }

  List<String> get _availableTimes {
    switch (_selectedRestaurant?['id']) {
      case 'la_terraza':
        return [
          '6:00 PM',
          '6:30 PM',
          '7:00 PM',
          '7:30 PM',
          '8:00 PM',
          '8:30 PM',
          '9:00 PM',
          '9:30 PM',
        ];
      case 'sakura':
        return [
          '12:00 PM',
          '12:30 PM',
          '1:00 PM',
          '6:00 PM',
          '6:30 PM',
          '7:00 PM',
          '7:30 PM',
          '8:00 PM',
          '8:30 PM',
        ];
      case 'el_jardin':
        return [
          '12:00 PM',
          '1:00 PM',
          '2:00 PM',
          '6:00 PM',
          '7:00 PM',
          '8:00 PM',
          '9:00 PM',
        ];
      case 'the_grill':
        return [
          '5:00 PM',
          '5:30 PM',
          '6:00 PM',
          '6:30 PM',
          '7:00 PM',
          '7:30 PM',
          '8:00 PM',
          '8:30 PM',
          '9:00 PM',
        ];
      case 'pool_bar':
        return [
          '11:00 AM',
          '12:00 PM',
          '1:00 PM',
          '2:00 PM',
          '3:00 PM',
          '4:00 PM',
          '5:00 PM',
          '6:00 PM',
        ];
      default:
        return ['7:00 PM'];
    }
  }

  double get _totalPrice {
    double total = 0;
    for (final dish in _selectedDishes) {
      total += dish['price'] as double;
    }
    return total;
  }

  void _toggleDish(Map<String, dynamic> dish) {
    setState(() {
      final index = _selectedDishes.indexWhere((d) => d['id'] == dish['id']);
      if (index >= 0) {
        _selectedDishes.removeAt(index);
        _dishCustomizations.remove(dish['id']);
      } else {
        _selectedDishes.add(dish);
      }
    });
  }

  void _toggleCustomization(String dishId, String customization) {
    setState(() {
      if (!_dishCustomizations.containsKey(dishId)) {
        _dishCustomizations[dishId] = [];
      }
      if (_dishCustomizations[dishId]!.contains(customization)) {
        _dishCustomizations[dishId]!.remove(customization);
      } else {
        _dishCustomizations[dishId]!.add(customization);
      }
    });
  }

  Future<void> _processBooking() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    final reservation = Reservation(
      id: 'res_${DateTime.now().millisecondsSinceEpoch}',
      name: _selectedRestaurant!['name'] as String,
      imageUrl: _selectedRestaurant!['image'] as String,
      type: ReservationType.place,
      status: ReservationStatus.upcoming,
      date: _selectedDate,
      time: _selectedTime,
      guestCount: _guestCount,
      price: _totalPrice,
      category: 'Dining',
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
                  Icons.restaurant,
                  color: AppColors.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Table Reserved!', style: AppTextStyles.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your dining experience awaits.',
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
                      Icons.restaurant,
                      _selectedRestaurant!['name'] as String,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      Icons.calendar_today,
                      Formatters.date(_selectedDate, format: 'EEEE, MMM dd'),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(Icons.access_time, _selectedTime),
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(Icons.people, '$_guestCount guests'),
                    if (_selectedDishes.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _buildInfoRow(
                        Icons.receipt,
                        '${_selectedDishes.length} items pre-ordered',
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
                child: const Icon(Icons.restaurant, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dining', style: AppTextStyles.headlineMedium),
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
    switch (_currentStep) {
      case 0:
        return 'Choose a restaurant';
      case 1:
        return 'Pre-order dishes (optional)';
      case 2:
        return 'Select date & time';
      default:
        return '';
    }
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index <= _currentStep;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: index < 2 ? AppSpacing.xs : 0),
              height: 4,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildRestaurantSelection();
      case 1:
        return _buildMenuSelection();
      case 2:
        return _buildDateTimeSelection();
      default:
        return const SizedBox();
    }
  }

  Widget _buildRestaurantSelection() {
    return ListView.builder(
      key: const ValueKey('restaurants'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = _restaurants[index];
        final isSelected = _selectedRestaurant?['id'] == restaurant['id'];
        return GestureDetector(
          onTap: () => setState(() => _selectedRestaurant = restaurant),
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
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSpacing.borderRadius),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: restaurant['image'] as String,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(height: 120, color: AppColors.shimmerBase),
                    errorWidget: (context, url, error) => Container(
                      height: 120,
                      color: AppColors.shimmerBase,
                      child: const Icon(Icons.restaurant),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  restaurant['name'] as String,
                                  style: AppTextStyles.titleMedium,
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceVariant,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    restaurant['priceRange'] as String,
                                    style: AppTextStyles.caption,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              restaurant['cuisine'] as String,
                              style: AppTextStyles.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  (restaurant['rating'] as double).toString(),
                                  style: AppTextStyles.labelSmall,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: AppColors.textTertiary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant['hours'] as String,
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
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

  Widget _buildMenuSelection() {
    final groupedMenu = <String, List<Map<String, dynamic>>>{};
    for (final dish in _menu) {
      final category = dish['category'] as String;
      groupedMenu.putIfAbsent(category, () => []);
      groupedMenu[category]!.add(dish);
    }

    return SingleChildScrollView(
      key: const ValueKey('menu'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppSpacing.cardPadding,
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Pre-ordering is optional. You can also order at the restaurant.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...groupedMenu.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: AppTextStyles.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                ...entry.value.map((dish) => _buildDishCard(dish)),
                const SizedBox(height: AppSpacing.md),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDishCard(Map<String, dynamic> dish) {
    final isSelected = _selectedDishes.any((d) => d['id'] == dish['id']);
    final customizations = _dishCustomizations[dish['id']] ?? [];

    return AnimatedContainer(
      duration: AppDurations.fast,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryWithOpacity(0.05)
            : AppColors.surface,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => _toggleDish(dish),
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dish['name'] as String,
                          style: AppTextStyles.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dish['description'] as String,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    Formatters.currency(dish['price'] as double),
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customize:', style: AppTextStyles.labelSmall),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: (dish['customizations'] as List<String>).map((c) {
                      final isCustomSelected = customizations.contains(c);
                      return GestureDetector(
                        onTap: () =>
                            _toggleCustomization(dish['id'] as String, c),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isCustomSelected
                                ? AppColors.primary
                                : AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.borderRadiusXl,
                            ),
                          ),
                          child: Text(
                            c,
                            style: AppTextStyles.caption.copyWith(
                              color: isCustomSelected
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

  Widget _buildDateTimeSelection() {
    return SingleChildScrollView(
      key: const ValueKey('datetime'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Number of Guests', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              IconButton(
                onPressed: _guestCount > 1
                    ? () => setState(() => _guestCount--)
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: _guestCount > 1
                    ? AppColors.primary
                    : AppColors.textTertiary,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Text(
                  '$_guestCount',
                  style: AppTextStyles.headlineMedium,
                ),
              ),
              IconButton(
                onPressed: _guestCount < 12
                    ? () => setState(() => _guestCount++)
                    : null,
                icon: const Icon(Icons.add_circle_outline),
                color: _guestCount < 12
                    ? AppColors.primary
                    : AppColors.textTertiary,
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                _guestCount == 1 ? 'guest' : 'guests',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Select Date', style: AppTextStyles.titleMedium),
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
          Text('Select Time', style: AppTextStyles.titleMedium),
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
          const SizedBox(height: AppSpacing.lg),
          Text('Special Requests', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Allergies, celebrations, seating preferences...',
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
            onChanged: (value) => _specialRequests = value,
          ),
          if (_selectedDishes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _buildOrderSummary(),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pre-Order Summary', style: AppTextStyles.titleMedium),
          const SizedBox(height: AppSpacing.md),
          ..._selectedDishes.map((dish) {
            final customizations = _dishCustomizations[dish['id']] ?? [];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dish['name'] as String,
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(
                        Formatters.currency(dish['price'] as double),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  if (customizations.isNotEmpty)
                    Text(
                      customizations.join(', '),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            );
          }),
          const Divider(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Estimated Total', style: AppTextStyles.titleMedium),
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

  Widget _buildBottomBar() {
    final canProceed = _currentStep == 0 ? _selectedRestaurant != null : true;

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
          if (_currentStep == 2 && _selectedDishes.isNotEmpty) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Pre-order', style: AppTextStyles.caption),
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
            flex: _currentStep == 2 && _selectedDishes.isNotEmpty ? 2 : 1,
            child: PrimaryButton(
              text: _currentStep == 2
                  ? (_isProcessing ? 'Reserving...' : 'Reserve Table')
                  : (_currentStep == 1 ? 'Continue' : 'Select Restaurant'),
              isLoading: _isProcessing,
              onPressed: canProceed && !_isProcessing
                  ? () {
                      if (_currentStep < 2) {
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
