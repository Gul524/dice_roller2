import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dice Logo with bouncing animation
            Container(
                  width: AppSizes.splashLogoSize,
                  height: AppSizes.splashLogoSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.diceShadow,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Dice dot pattern (showing 5)
                      Positioned(top: 20, left: 20, child: _buildDot()),
                      Positioned(top: 20, right: 20, child: _buildDot()),
                      Positioned(top: 50, left: 50, child: _buildDot()),
                      Positioned(bottom: 20, left: 20, child: _buildDot()),
                      Positioned(bottom: 20, right: 20, child: _buildDot()),
                    ],
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .moveY(
                  begin: 0,
                  end: -20,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: -20,
                  end: 0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                )
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 0.95),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  begin: const Offset(1.05, 0.95),
                  end: const Offset(1, 1),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                ),

            const SizedBox(height: AppSizes.paddingXL),

            // App name
            Text(
                  'Dice Roller',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 500))
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: AppSizes.paddingS),

            // Subtitle
            Text('Roll & Play', style: Theme.of(context).textTheme.bodyMedium)
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 700))
                .slideY(begin: 0.3, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: AppColors.diceDot,
        shape: BoxShape.circle,
      ),
    );
  }
}
