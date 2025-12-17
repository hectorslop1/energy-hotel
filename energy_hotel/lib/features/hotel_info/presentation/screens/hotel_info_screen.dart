import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HotelInfoScreen extends StatefulWidget {
  const HotelInfoScreen({super.key});

  @override
  State<HotelInfoScreen> createState() => _HotelInfoScreenState();
}

class _HotelInfoScreenState extends State<HotelInfoScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _amenities = [
    {
      'name': 'Swimming Pool',
      'hours': '7:00 AM - 10:00 PM',
      'location': 'Ground Floor',
      'icon': Icons.pool,
      'notes': 'Towels available at pool deck',
    },
    {
      'name': 'Fitness Center',
      'hours': '24 Hours',
      'location': '2nd Floor',
      'icon': Icons.fitness_center,
      'notes': 'Room key required for access',
    },
    {
      'name': 'Spa & Wellness',
      'hours': '9:00 AM - 9:00 PM',
      'location': '3rd Floor',
      'icon': Icons.spa,
      'notes': 'Reservations recommended',
    },
    {
      'name': 'Business Center',
      'hours': '24 Hours',
      'location': 'Lobby Level',
      'icon': Icons.computer,
      'notes': 'Printing services available',
    },
    {
      'name': 'Kids Club',
      'hours': '9:00 AM - 6:00 PM',
      'location': 'Ground Floor',
      'icon': Icons.child_care,
      'notes': 'Ages 4-12, supervision included',
    },
    {
      'name': 'Gift Shop',
      'hours': '8:00 AM - 10:00 PM',
      'location': 'Lobby',
      'icon': Icons.shopping_bag,
      'notes': 'Souvenirs, essentials, snacks',
    },
  ];

  final List<Map<String, dynamic>> _restaurants = [
    {
      'name': 'La Terraza',
      'cuisine': 'Mediterranean',
      'hours': '6:00 PM - 11:00 PM',
      'location': 'Rooftop',
      'dress': 'Smart Casual',
    },
    {
      'name': 'Sakura',
      'cuisine': 'Japanese',
      'hours': '12:00 PM - 10:00 PM',
      'location': '1st Floor',
      'dress': 'Casual',
    },
    {
      'name': 'El Jardín',
      'cuisine': 'Mexican',
      'hours': '7:00 AM - 10:00 PM',
      'location': 'Garden Level',
      'dress': 'Casual',
    },
    {
      'name': 'The Grill House',
      'cuisine': 'Steakhouse',
      'hours': '5:00 PM - 11:00 PM',
      'location': '1st Floor',
      'dress': 'Smart Casual',
    },
    {
      'name': 'Pool Bar & Grill',
      'cuisine': 'Casual',
      'hours': '10:00 AM - 8:00 PM',
      'location': 'Pool Area',
      'dress': 'Casual/Swimwear',
    },
  ];

  final List<Map<String, dynamic>> _contacts = [
    {'name': 'Front Desk', 'number': '0', 'icon': Icons.desk},
    {'name': 'Room Service', 'number': '1', 'icon': Icons.room_service},
    {'name': 'Housekeeping', 'number': '2', 'icon': Icons.cleaning_services},
    {'name': 'Concierge', 'number': '3', 'icon': Icons.support_agent},
    {'name': 'Spa', 'number': '4', 'icon': Icons.spa},
    {'name': 'Valet', 'number': '5', 'icon': Icons.car_rental},
    {'name': 'Emergency', 'number': '911', 'icon': Icons.emergency},
    {'name': 'Security', 'number': '6', 'icon': Icons.security},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hotel Information'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildWifiSection(),
                _buildAmenitiesSection(),
                _buildDiningSection(),
                _buildContactsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = ['WiFi', 'Amenities', 'Dining', 'Contacts'];
    return Container(
      height: 50,
      margin: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWifiSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadiusLg),
            ),
            child: Column(
              children: [
                const Icon(Icons.wifi, color: Colors.white, size: 64),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'WiFi Network',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'EnergyHotel_Guest',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Password',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome2024!',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: 'Welcome2024!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password copied!')),
                        );
                      },
                      icon: const Icon(Icons.copy, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildInfoCard(
            icon: Icons.speed,
            title: 'Connection Speed',
            subtitle: 'Up to 100 Mbps download',
          ),
          _buildInfoCard(
            icon: Icons.devices,
            title: 'Device Limit',
            subtitle: '5 devices per room',
          ),
          _buildInfoCard(
            icon: Icons.signal_wifi_4_bar,
            title: 'Coverage',
            subtitle: 'Available throughout the property',
          ),
          _buildInfoCard(
            icon: Icons.support,
            title: 'Need Help?',
            subtitle: 'Call IT Support: Dial 7',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
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
              color: AppColors.primaryWithOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _amenities.length,
      itemBuilder: (context, index) {
        final amenity = _amenities[index];
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
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primaryWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                ),
                child: Icon(
                  amenity['icon'] as IconData,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      amenity['name'] as String,
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          amenity['hours'] as String,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          amenity['location'] as String,
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                    if (amenity['notes'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        amenity['notes'] as String,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.accent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDiningSection() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = _restaurants[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurant['name'] as String,
                    style: AppTextStyles.titleMedium,
                  ),
                  Container(
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
                    child: Text(
                      restaurant['cuisine'] as String,
                      style: AppTextStyles.labelSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  _buildDiningInfo(
                    Icons.access_time,
                    restaurant['hours'] as String,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _buildDiningInfo(
                    Icons.location_on,
                    restaurant['location'] as String,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _buildDiningInfo(
                Icons.checkroom,
                'Dress: ${restaurant['dress']}',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDiningInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
        const SizedBox(width: 4),
        Text(text, style: AppTextStyles.caption),
      ],
    );
  }

  Widget _buildContactsSection() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.5,
      ),
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        final isEmergency = contact['name'] == 'Emergency';
        return Container(
          decoration: BoxDecoration(
            color: isEmergency
                ? AppColors.error.withValues(alpha: 0.1)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
            border: Border.all(
              color: isEmergency ? AppColors.error : AppColors.border,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Calling ${contact['name']}...')),
                );
              },
              borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      contact['icon'] as IconData,
                      color: isEmergency ? AppColors.error : AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      contact['name'] as String,
                      style: AppTextStyles.titleSmall.copyWith(
                        color: isEmergency ? AppColors.error : null,
                      ),
                    ),
                    Text(
                      'Dial ${contact['number']}',
                      style: AppTextStyles.caption.copyWith(
                        color: isEmergency
                            ? AppColors.error
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
