# Dice Roller App - iOS Style

A realistic dice rolling application for Flutter with iOS styling and smooth animations.

## Features

### ✨ Core Features
- **Realistic Dice Rolling**: 3D rotation animation with realistic physics
- **iOS Style Design**: Clean, modern interface following iOS design guidelines
- **Sound Effects**: Optional dice rolling sound (customizable)
- **Multiple Dice**: Support for 1-4 dice simultaneously
- **Player Turn System**: Color-coded player turns (like Ludo board game)

### 🎨 Customization Options
1. **Sound Effects**: Enable/disable dice rolling sounds
2. **Color Effects**: Toggle player turn color indication
3. **Dice Size**: Choose from Small, Medium, Large, or XLarge
4. **Dice Limit**: Set maximum number of dice (1-4)
5. **Number of Players**: Support for 2-4 players
6. **All-6s Bonus Limit**: Configure consecutive all-6 bonus rolls (1-5)
7. **Dynamic Dice Control**: Add or remove dice on the fly

### 🎲 Special Game Mechanic: All-6s Bonus
When all active dice show 6, the current player gets a bonus turn!
- Configurable limit: Set how many consecutive all-6 rolls a player can get (1-5 times)
- Visual indicator: Shows current streak count on the player badge
- Automatic progression: After reaching the limit, turn passes to the next player
- Notification: Display a celebration message when all dice show 6

### 🎯 Screens
1. **Splash Screen**: Animated logo with bouncing effect
2. **Home Screen**: Main dice board with bottom navigation
3. **Settings Screen**: Complete customization panel

## Setup Instructions

### 1. Install Dependencies
Run the following command to install all required packages:
```bash
flutter pub get
```

### 2. Add Sound File (Optional)
For dice rolling sound effects, add an MP3 file:
- Create file: `assets/audio/dice_roll.mp3`
- You can download free dice rolling sounds from:
  - [FreeSound](https://freesound.org/)
  - [Zapsplat](https://www.zapsplat.com/)
  - [Mixkit](https://mixkit.co/free-sound-effects/dice/)

### 3. Run the App
```bash
flutter run
```

## Project Structure
```
lib/
├── config/
│   ├── app_colors.dart      # Color scheme
│   ├── app_sizes.dart       # Size constants
│   └── app_theme.dart       # App theme configuration
├── models/
│   └── app_settings.dart    # Settings state management
├── screens/
│   ├── splash_screen.dart   # Animated splash screen
│   ├── home_screen.dart     # Main dice board
│   └── settings_screen.dart # Settings panel
├── widgets/
│   └── dice_widget.dart     # Reusable dice component
└── main.dart                # App entry point
```

## How to Use

### Rolling Dice
1. Tap the **Play** button in the center of bottom navigation
2. Watch the realistic 3D dice rolling animation
3. If all dice show 6, you get a bonus turn (up to your configured limit)!
4. Turn automatically switches to next player (if color effects enabled)

### Adding/Removing Dice
- Tap **Add** to add a dice (up to your set limit)
- Tap **Remove** to remove a dice (minimum 1 required)

### Settings
Access settings by tapping the **Settings** button:
- Toggle sound effects on/off
- Enable/disable color effects for player turns
- Adjust dice size for better visibility
- Set dice limit (1-4)
- Set all-6s bonus limit (1-5 consecutive rolls)
- Configure number of players (2-4)
- View player color indicators

## Player Color System
When color effects are enabled, each player gets a distinct color:
- **Player 1**: Red
- **Player 2**: Green
- **Player 3**: Yellow
- **Player 4**: Blue

The background and dice board subtly change color to indicate whose turn it is, similar to a Ludo board game.

## Technical Details

### Dependencies
- **provider**: State management
- **audioplayers**: Sound effects
- **shared_preferences**: Settings persistence
- **flutter_animate**: Smooth animations

### Animations
- Splash screen logo bounce effect
- 3D dice rotation during roll
- Smooth page transitions
- Bottom navigation interactions

## Troubleshooting

### Sound Not Playing
- Ensure `assets/audio/dice_roll.mp3` exists
- Check that sound is enabled in settings
- Verify audio file format is MP3

### App Not Building
```bash
flutter clean
flutter pub get
flutter run
```

## Future Enhancements
- [ ] Haptic feedback on dice roll
- [ ] Dice roll history
- [ ] Custom dice colors
- [ ] Score tracking
- [ ] Multiple dice roll modes
- [ ] Animation speed control

## License
This project is open source and available for educational purposes.

---

**Enjoy your realistic dice rolling experience! 🎲**
