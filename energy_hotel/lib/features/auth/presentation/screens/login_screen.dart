import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref
          .read(authProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
      if (!success && mounted) {
        _showErrorSnackBar();
      }
    }
  }

  void _showErrorSnackBar() {
    final errorMessage = ref.read(authProvider).errorMessage;
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          ),
        ),
      );
      ref.read(authProvider.notifier).clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          _buildAnimatedBackground(size),

          // Decorative circles
          _buildDecorativeElements(size),

          // Main content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.08),
                      _buildHeader(),
                      const SizedBox(height: 48),
                      _buildForm(isLoading),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground(Size size) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFF8FAFC),
                Color.lerp(
                  const Color(0xFFE0E7FF),
                  const Color(0xFFDBEAFE),
                  _pulseController.value,
                )!,
                const Color(0xFFF1F5F9),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDecorativeElements(Size size) {
    return Stack(
      children: [
        // Animated waves at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: size.height * 0.25,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(size.width, size.height * 0.25),
                  painter: _WavePainter(
                    animationValue: _pulseController.value,
                    color1: AppColors.primary.withValues(alpha: 0.1),
                    color2: AppColors.accent.withValues(alpha: 0.08),
                    color3: AppColors.primary.withValues(alpha: 0.05),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Animated Logo
        ScaleTransition(
          scale: _logoScaleAnimation,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow effect
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 60 + (_pulseController.value * 10),
                      height: 60 + (_pulseController.value * 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(
                          alpha: 0.1 + (_pulseController.value * 0.1),
                        ),
                      ),
                    );
                  },
                ),
                const Icon(Icons.hotel_rounded, color: Colors.white, size: 48),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Welcome to',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
          ).createShader(bounds),
          child: Text(
            'Energy Hotel',
            style: AppTextStyles.displayLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign In',
              style: AppTextStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your credentials to continue',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _emailController,
              hint: 'Email Address',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              enabled: !isLoading,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _passwordController,
              hint: 'Password',
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              enabled: !isLoading,
              validator: Validators.password,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              onSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 24),
            _buildLoginButton(isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool enabled = true,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    void Function(String)? onSubmitted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        validator: validator,
        onFieldSubmitted: onSubmitted,
        style: AppTextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 12, right: 8),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 48),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : _handleLogin,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign In',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animationValue;
  final Color color1;
  final Color color2;
  final Color color3;

  _WavePainter({
    required this.animationValue,
    required this.color1,
    required this.color2,
    required this.color3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = color1
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = color2
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = color3
      ..style = PaintingStyle.fill;

    // Phase offset based on animation (full 2*pi cycle = seamless loop)
    final phase = animationValue * 2 * math.pi;

    // First wave (back)
    final path1 = Path();
    path1.moveTo(0, size.height);
    path1.lineTo(0, size.height * 0.6);

    for (double i = 0; i <= size.width; i++) {
      final x = i / size.width * 2 * math.pi;
      path1.lineTo(
        i,
        size.height * 0.6 +
            math.sin(x + phase) * 18 +
            math.sin(x * 2 + phase * 2) * 8,
      );
    }
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Second wave (middle)
    final path2 = Path();
    path2.moveTo(0, size.height);
    path2.lineTo(0, size.height * 0.7);

    for (double i = 0; i <= size.width; i++) {
      final x = i / size.width * 2 * math.pi;
      path2.lineTo(
        i,
        size.height * 0.7 +
            math.sin(x + phase + math.pi / 3) * 14 +
            math.sin(x * 2 + phase * 2 + math.pi / 4) * 6,
      );
    }
    path2.lineTo(size.width, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Third wave (front)
    final path3 = Path();
    path3.moveTo(0, size.height);
    path3.lineTo(0, size.height * 0.8);

    for (double i = 0; i <= size.width; i++) {
      final x = i / size.width * 2 * math.pi;
      path3.lineTo(
        i,
        size.height * 0.8 +
            math.sin(x + phase + math.pi / 2) * 10 +
            math.sin(x * 2 + phase * 2 + math.pi / 2) * 5,
      );
    }
    path3.lineTo(size.width, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
