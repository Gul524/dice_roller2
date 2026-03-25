import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';
import '../models/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: false,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            // _buildHeader(context),
            // Settings list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                children: [
                  _buildSectionTitle(context, 'Audio Settings'),
                  _buildSoundToggle(context),

                  const SizedBox(height: AppSizes.paddingL),

                  _buildSectionTitle(context, 'Appearance'),
                  _buildThemeSelector(context),

                  const SizedBox(height: AppSizes.paddingL),

                  _buildSectionTitle(context, 'Visual Settings'),
                  _buildColorEffectToggle(context),
                  const SizedBox(height: AppSizes.paddingS),
                  _buildPlayerCountSelector(context),
                  const SizedBox(height: AppSizes.paddingS),
                  _buildAllSixesLimitSelector(context),

                  const SizedBox(height: AppSizes.paddingL),

                  _buildSectionTitle(context, 'Dice Settings'),
                  _buildDiceSizeSelector(context),
                  const SizedBox(height: AppSizes.paddingS),
                  _buildDiceLimitSelector(context),

                  const SizedBox(height: AppSizes.paddingL),

                  _buildSectionTitle(context, 'Player Colors Preview'),
                  _buildPlayerColorsPreview(context),

                  const SizedBox(height: AppSizes.paddingXL),

                  _buildResetButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          ),
          Expanded(
            child: Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
          ),
          const SizedBox(width: 44), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSizes.paddingS,
        bottom: AppSizes.paddingS,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: theme.textTheme.bodyMedium?.color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSoundToggle(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: settings.soundEnabled ? Icons.volume_up : Icons.volume_off,
          title: 'Sound Effects',
          subtitle: 'Play sound while rolling dice',
          trailing: Switch(
            value: settings.soundEnabled,
            onChanged: (_) => settings.toggleSound(),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: Icons.brightness_6,
          title: 'Theme Mode',
          subtitle: 'Choose app appearance',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildThemeButton(
                  context,
                  icon: Icons.brightness_auto,
                  label: 'Auto',
                  isSelected: settings.themeMode == AppThemeMode.system,
                  onTap: () => settings.setThemeMode(AppThemeMode.system),
                ),
                const SizedBox(width: 6),
                _buildThemeButton(
                  context,
                  icon: Icons.light_mode,
                  label: 'Light',
                  isSelected: settings.themeMode == AppThemeMode.light,
                  onTap: () => settings.setThemeMode(AppThemeMode.light),
                ),
                const SizedBox(width: 6),
                _buildThemeButton(
                  context,
                  icon: Icons.dark_mode,
                  label: 'Dark',
                  isSelected: settings.themeMode == AppThemeMode.dark,
                  onTap: () => settings.setThemeMode(AppThemeMode.dark),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: isSelected ? colorScheme.primary : colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimary
                  : theme.textTheme.bodyMedium?.color,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? colorScheme.primary
                  : theme.textTheme.bodyMedium?.color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorEffectToggle(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: Icons.palette,
          title: 'Color Effects',
          subtitle: 'Show player turn with colors (like Ludo)',
          trailing: Switch(
            value: settings.colorEffectEnabled,
            onChanged: (_) => settings.toggleColorEffect(),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  Widget _buildPlayerCountSelector(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: Icons.people,
          title: 'Number of Players',
          subtitle: 'Set how many players are playing',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                final count = index + 2; // 2, 3, 4 players
                final isSelected = settings.numberOfPlayers == count;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => settings.setNumberOfPlayers(count),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppSizes.radiusS),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAllSixesLimitSelector(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: Icons.casino,
          title: 'All-6s Bonus Limit',
          subtitle: 'Consecutive all-6 rolls before turn passes',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    final limit = index + 1;
                    final isSelected = settings.allSixesLimit == limit;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: GestureDetector(
                        onTap: () => settings.setAllSixesLimit(limit),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusS,
                            ),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$limit',
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(2, (index) {
                    final limit = index + 1 + 3; // 4, 5 consecutive all-6s
                    final isSelected = settings.allSixesLimit == limit;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: GestureDetector(
                        onTap: () => settings.setAllSixesLimit(limit),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusS,
                            ),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$limit',
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiceSizeSelector(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: Icons.photo_size_select_large,
          title: 'Dice Size',
          subtitle: 'Change the size of dice on board',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: DiceSize.values.map((size) {
                    final isSelected = settings.diceSize == size;
                    String label;
                    switch (size) {
                      case DiceSize.small:
                        label = 'S';
                        break;
                      case DiceSize.medium:
                        label = 'M';
                        break;
                      case DiceSize.large:
                        label = 'L';
                        break;
                      case DiceSize.xLarge:
                        label = 'XL';
                        break;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: GestureDetector(
                        onTap: () => settings.setDiceSize(size),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusS,
                            ),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              label,
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiceLimitSelector(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return _buildSettingCard(
          context,
          icon: Icons.grid_view,
          title: 'Dice Limit',
          subtitle: 'Maximum number of dice (1-4)',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(2, (index) {
                    final limit = index + 1;
                    final isSelected = settings.diceLimit == limit;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => settings.setDiceLimit(limit),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusS,
                            ),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$limit',
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(2, (index) {
                    final limit = index + 1 + 2; // 3, 4 dice limit
                    final isSelected = settings.diceLimit == limit;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => settings.setDiceLimit(limit),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusS,
                            ),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$limit',
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayerColorsPreview(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
          padding: const EdgeInsets.all(AppSizes.paddingM),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: Column(
            children: [
              Text(
                'Player Turn Colors',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.titleMedium?.color,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(settings.numberOfPlayers, (index) {
                  return Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.playerColors[index],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: settings.currentPlayerIndex == index
                                ? theme.colorScheme.onSurface
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Player ${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, settings, child) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Reset Dice'),
                content: const Text('Reset all dice to default configuration?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    onPressed: () {
                      settings.resetDice();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
            padding: const EdgeInsets.all(AppSizes.paddingM),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              border: Border.all(
                color: Theme.of(context).colorScheme.error.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.refresh,
                  color: Theme.of(context).colorScheme.onError,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Reset Dice Configuration',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.paddingXS,
        horizontal: AppSizes.paddingS,
      ),
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingS),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: Icon(icon, color: colorScheme.primary, size: AppSizes.iconM),
          ),
          const SizedBox(width: AppSizes.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
