import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';
import '../models/app_settings.dart';
import '../widgets/dice_widget.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> _diceValues = [1, 1, 1, 1];
  bool _isRolling = false;
  final Random _random = Random();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _rollDice() async {
    if (_isRolling) return;

    setState(() {
      _isRolling = true;
    });

    final settings = Provider.of<AppSettings>(context, listen: false);

    // Play sound if enabled
    if (settings.soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource('audio/dice_roll.mp3'));
      } catch (e) {
        // Sound file not found, continue without sound
        debugPrint('Sound file not found: $e');
      }
    }

    // Generate random values
    for (int i = 0; i < 4; i++) {
      if (settings.activeDice[i]) {
        _diceValues[i] = _random.nextInt(6) + 1;
      }
    }

    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isRolling = false;
    });

    // Handle turn progression based on all-6s rule
    final playerGetsAnotherTurn = settings.handleDiceRoll(_diceValues);

    // Show notification if player got all 6s
    if (playerGetsAnotherTurn && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '🎉 All 6s! Player ${settings.currentPlayerIndex + 1} rolls again! (${settings.consecutiveAllSixes}/${settings.allSixesLimit})',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: settings.currentPlayerColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final defaultBg = isDark
            ? AppColors.backgroundDark
            : AppColors.background;

        return Scaffold(
          backgroundColor: settings.colorEffectEnabled
              ? settings.currentPlayerColor.withOpacity(0.1)
              : defaultBg,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(settings),

                // Dice Board
                Expanded(child: _buildDiceBoard(settings)),

                // Bottom Navigation
                _buildBottomNavigation(settings),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AppSettings settings) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Player indicator
          if (settings.colorEffectEnabled)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                    vertical: AppSizes.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: settings.currentPlayerColor,
                    borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  ),
                  child: Text(
                    'Player ${settings.currentPlayerIndex + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (settings.consecutiveAllSixes > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '🎲 ${settings.consecutiveAllSixes}/${settings.allSixesLimit}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          else
            const SizedBox.shrink(),

          // Title
          Text('Dice Roller', style: Theme.of(context).textTheme.titleMedium),

          // Active dice count
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM,
              vertical: AppSizes.paddingS,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusL),
            ),
            child: Row(
              children: [
                const Icon(Icons.grid_view, size: 16, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  '${settings.activeDiceCount}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiceBoard(AppSettings settings) {
    final activeDiceIndices = <int>[];
    for (int i = 0; i < 4; i++) {
      if (settings.activeDice[i]) {
        activeDiceIndices.add(i);
      }
    }

    return Container(
      margin: const EdgeInsets.all(AppSizes.paddingM),
      padding: const EdgeInsets.all(AppSizes.paddingL),
      decoration: BoxDecoration(
        color: settings.colorEffectEnabled
            ? settings.currentPlayerColor.withOpacity(0.2)
            : AppColors.diceBoard,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        boxShadow: [
          BoxShadow(
            color: settings.colorEffectEnabled
                ? settings.currentPlayerColor.withOpacity(0.3)
                : AppColors.diceShadow,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Wrap(
          spacing: AppSizes.paddingL,
          runSpacing: AppSizes.paddingL,
          alignment: WrapAlignment.center,
          children: activeDiceIndices.map((index) {
            return DiceWidget(
              size: settings.diceSizeValue,
              isRolling: _isRolling,
              value: _diceValues[index],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(AppSettings settings) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(AppSizes.bottomNavPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingL,
        vertical: AppSizes.paddingM,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.navBarBackgroundDark
            : AppColors.navBarBackground,
        borderRadius: BorderRadius.circular(AppSizes.bottomNavRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.diceShadow,
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Remove dice button
          _buildNavButton(
            icon: Icons.remove_circle,
            label: 'Remove',
            onTap: () {
              final lastActiveIndex = settings.activeDice.lastIndexWhere(
                (d) => d,
              );
              if (lastActiveIndex != -1) {
                settings.toggleDice(lastActiveIndex);
              }
            },
            enabled: settings.activeDiceCount > 1,
          ),

          // Play button (Roll)
          _buildPlayButton(),

          // Add dice button
          _buildNavButton(
            icon: Icons.add_circle,
            label: 'Add',
            onTap: () {
              final firstInactiveIndex = settings.activeDice.indexWhere(
                (d) => !d,
              );
              if (firstInactiveIndex != -1) {
                settings.toggleDice(firstInactiveIndex);
              }
            },
            enabled: settings.activeDiceCount < settings.diceLimit,
          ),

          // Settings button
          _buildNavButton(
            icon: Icons.settings,
            label: 'Settings',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            enabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.navBarIconDark : AppColors.navBarIcon;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: AppSizes.iconL),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return GestureDetector(
      onTap: _isRolling ? null : _rollDice,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          _isRolling ? Icons.hourglass_empty : Icons.play_arrow,
          color: Colors.white,
          size: AppSizes.iconL,
        ),
      ),
    );
  }
}
