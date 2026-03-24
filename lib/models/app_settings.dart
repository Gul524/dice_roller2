import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';

enum DiceSize { small, medium, large, xLarge }

enum AppThemeMode { system, light, dark }

class AppSettings extends ChangeNotifier {
  // Settings
  bool _soundEnabled = true;
  bool _colorEffectEnabled = true;
  int _diceLimit = 2;
  DiceSize _diceSize = DiceSize.medium;
  AppThemeMode _themeMode = AppThemeMode.system; // Theme mode
  int _currentPlayerIndex = 0;
  int _numberOfPlayers = 2;
  int _allSixesLimit = 2; // How many consecutive all-6s before turn passes
  int _consecutiveAllSixes = 0; // Counter for consecutive all-6 rolls
  final List<bool> _activeDice = [true, true, false, false]; // Max 4 dice

  // Getters
  bool get soundEnabled => _soundEnabled;
  bool get colorEffectEnabled => _colorEffectEnabled;
  int get diceLimit => _diceLimit;
  DiceSize get diceSize => _diceSize;
  AppThemeMode get themeMode => _themeMode;
  int get currentPlayerIndex => _currentPlayerIndex;
  int get numberOfPlayers => _numberOfPlayers;
  int get allSixesLimit => _allSixesLimit;
  int get consecutiveAllSixes => _consecutiveAllSixes;
  List<bool> get activeDice => _activeDice;

  // Get ThemeMode for MaterialApp
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  Color get currentPlayerColor {
    if (!_colorEffectEnabled) {
      return AppColors.diceBoard;
    }
    return AppColors.playerColors[_currentPlayerIndex %
        AppColors.playerColors.length];
  }

  double get diceSizeValue {
    switch (_diceSize) {
      case DiceSize.small:
        return AppSizes.diceSmall;
      case DiceSize.medium:
        return AppSizes.diceMedium;
      case DiceSize.large:
        return AppSizes.diceLarge;
      case DiceSize.xLarge:
        return AppSizes.diceXLarge;
    }
  }

  int get activeDiceCount => _activeDice.where((active) => active).length;

  // Load settings
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _soundEnabled = prefs.getBool('soundEnabled') ?? true;
    _colorEffectEnabled = prefs.getBool('colorEffectEnabled') ?? true;
    _diceLimit = prefs.getInt('diceLimit') ?? 2;
    _numberOfPlayers = prefs.getInt('numberOfPlayers') ?? 2;
    _allSixesLimit = prefs.getInt('allSixesLimit') ?? 2;

    final themeModeIndex = prefs.getInt('themeMode') ?? 0;
    _themeMode = AppThemeMode.values[themeModeIndex];

    final diceSizeIndex = prefs.getInt('diceSize') ?? 1;
    _diceSize = DiceSize.values[diceSizeIndex];

    // Load active dice
    for (int i = 0; i < 4; i++) {
      _activeDice[i] = prefs.getBool('activeDice_$i') ?? (i < _diceLimit);
    }

    notifyListeners();
  }

  // Save settings
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundEnabled', _soundEnabled);
    await prefs.setBool('colorEffectEnabled', _colorEffectEnabled);
    await prefs.setInt('diceLimit', _diceLimit);
    await prefs.setInt('diceSize', _diceSize.index);
    await prefs.setInt('numberOfPlayers', _numberOfPlayers);
    await prefs.setInt('allSixesLimit', _allSixesLimit);
    await prefs.setInt('themeMode', _themeMode.index);

    // Save active dice
    for (int i = 0; i < 4; i++) {
      await prefs.setBool('activeDice_$i', _activeDice[i]);
    }
  }

  // Setters
  void toggleSound() {
    _soundEnabled = !_soundEnabled;
    _saveSettings();
    notifyListeners();
  }

  void toggleColorEffect() {
    _colorEffectEnabled = !_colorEffectEnabled;
    _saveSettings();
    notifyListeners();
  }

  void setDiceLimit(int limit) {
    if (limit >= 1 && limit <= 4) {
      _diceLimit = limit;
      // Update active dice based on limit
      for (int i = 0; i < 4; i++) {
        _activeDice[i] = i < limit;
      }
      _saveSettings();
      notifyListeners();
    }
  }

  void setDiceSize(DiceSize size) {
    _diceSize = size;
    _saveSettings();
    notifyListeners();
  }

  void setThemeMode(AppThemeMode mode) {
    _themeMode = mode;
    _saveSettings();
    notifyListeners();
  }

  void setNumberOfPlayers(int count) {
    if (count >= 2 && count <= 4) {
      _numberOfPlayers = count;
      if (_currentPlayerIndex >= count) {
        _currentPlayerIndex = 0;
      }
      _saveSettings();
      notifyListeners();
    }
  }

  void nextPlayer() {
    _currentPlayerIndex = (_currentPlayerIndex + 1) % _numberOfPlayers;
    _consecutiveAllSixes = 0; // Reset counter when moving to next player
    notifyListeners();
  }

  void setAllSixesLimit(int limit) {
    if (limit >= 1 && limit <= 5) {
      _allSixesLimit = limit;
      _saveSettings();
      notifyListeners();
    }
  }

  // Check if all active dice are 6 and handle turn progression
  // Returns true if player gets another turn (all 6s and under limit)
  bool handleDiceRoll(List<int> diceValues) {
    if (!_colorEffectEnabled) {
      return false; // No turn logic when color effects are disabled
    }

    // Check if all active dice show 6
    bool allActiveDiceAreSix = true;
    for (int i = 0; i < 4; i++) {
      if (_activeDice[i] && diceValues[i] != 6) {
        allActiveDiceAreSix = false;
        break;
      }
    }

    if (allActiveDiceAreSix) {
      _consecutiveAllSixes++;

      // Check if player exceeded the limit
      if (_consecutiveAllSixes >= _allSixesLimit) {
        nextPlayer(); // Move to next player after reaching limit
        return false;
      } else {
        notifyListeners();
        return true; // Same player continues
      }
    } else {
      // Not all 6s, reset counter and move to next player
      _consecutiveAllSixes = 0;
      nextPlayer();
      return false;
    }
  }

  void toggleDice(int index) {
    if (index >= 0 && index < 4) {
      final currentActiveCount = activeDiceCount;

      // Allow toggling off if more than 1 dice is active
      if (_activeDice[index] && currentActiveCount > 1) {
        _activeDice[index] = false;
      }
      // Allow toggling on if less than limit
      else if (!_activeDice[index] && currentActiveCount < _diceLimit) {
        _activeDice[index] = true;
      }

      _saveSettings();
      notifyListeners();
    }
  }

  void resetDice() {
    for (int i = 0; i < 4; i++) {
      _activeDice[i] = i < _diceLimit;
    }
    _saveSettings();
    notifyListeners();
  }
}
