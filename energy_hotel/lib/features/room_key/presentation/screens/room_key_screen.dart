import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class RoomKeyScreen extends StatefulWidget {
  const RoomKeyScreen({super.key});

  @override
  State<RoomKeyScreen> createState() => _RoomKeyScreenState();
}

class _RoomKeyScreenState extends State<RoomKeyScreen>
    with SingleTickerProviderStateMixin {
  bool _isUnlocking = false;
  bool _isUnlocked = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isUnlocking = false;
          _isUnlocked = true;
        });
        HapticFeedback.heavyImpact();
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() => _isUnlocked = false);
            _animationController.reset();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _unlock() {
    if (_isUnlocking || _isUnlocked) return;

    setState(() => _isUnlocking = true);
    HapticFeedback.mediumImpact();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Digital Room Key',
          style: AppTextStyles.headlineSmall.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: _buildKeyCard())),
            _buildRoomInfo(),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyCard() {
    return GestureDetector(
      onTap: _unlock,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                width: 280,
                height: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _isUnlocked
                        ? [
                            AppColors.success,
                            AppColors.success.withValues(alpha: 0.8),
                          ]
                        : [Colors.white, Colors.grey.shade200],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: (_isUnlocked ? AppColors.success : Colors.white)
                          .withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Card pattern
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: CustomPaint(
                          painter: _CardPatternPainter(
                            color: _isUnlocked
                                ? Colors.white.withValues(alpha: 0.1)
                                : AppColors.primary.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ENERGY',
                                style: AppTextStyles.headlineMedium.copyWith(
                                  color: _isUnlocked
                                      ? Colors.white
                                      : AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                              Icon(
                                Icons.wifi,
                                color: _isUnlocked
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ],
                          ),
                          Text(
                            'HOTEL',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: _isUnlocked
                                  ? Colors.white70
                                  : AppColors.textSecondary,
                              letterSpacing: 8,
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: AnimatedSwitcher(
                              duration: AppDurations.normal,
                              child: _isUnlocked
                                  ? const Icon(
                                      Icons.lock_open,
                                      key: ValueKey('unlocked'),
                                      size: 80,
                                      color: Colors.white,
                                    )
                                  : _isUnlocking
                                  ? SizedBox(
                                      key: const ValueKey('loading'),
                                      width: 80,
                                      height: 80,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        valueColor: AlwaysStoppedAnimation(
                                          AppColors.primary,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.lock_outline,
                                      key: const ValueKey('locked'),
                                      size: 80,
                                      color: AppColors.primary,
                                    ),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Text(
                              _isUnlocked
                                  ? 'DOOR UNLOCKED'
                                  : _isUnlocking
                                  ? 'UNLOCKING...'
                                  : 'TAP TO UNLOCK',
                              style: AppTextStyles.titleMedium.copyWith(
                                color: _isUnlocked
                                    ? Colors.white
                                    : AppColors.primary,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ROOM',
                                    style: AppTextStyles.caption.copyWith(
                                      color: _isUnlocked
                                          ? Colors.white70
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                  Text(
                                    '412',
                                    style: AppTextStyles.headlineMedium
                                        .copyWith(
                                          color: _isUnlocked
                                              ? Colors.white
                                              : AppColors.primary,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'VALID UNTIL',
                                    style: AppTextStyles.caption.copyWith(
                                      color: _isUnlocked
                                          ? Colors.white70
                                          : AppColors.textTertiary,
                                    ),
                                  ),
                                  Text(
                                    'DEC 20',
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: _isUnlocked
                                          ? Colors.white
                                          : AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoomInfo() {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildInfoItem(Icons.hotel, 'Ocean View Suite', 'Room Type'),
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          Expanded(
            child: _buildInfoItem(Icons.layers, '4th Floor', 'Location'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
        ),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              _buildStep('1', 'Hold phone near door lock'),
              const SizedBox(width: AppSpacing.sm),
              _buildStep('2', 'Tap the key card above'),
              const SizedBox(width: AppSpacing.sm),
              _buildStep('3', 'Wait for green light'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Keep Bluetooth enabled for best results',
            style: AppTextStyles.caption.copyWith(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
        ),
        child: Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number,
                  style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              text,
              style: AppTextStyles.caption.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardPatternPainter extends CustomPainter {
  final Color color;

  _CardPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 20.0;
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
