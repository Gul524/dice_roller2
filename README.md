# 🎲 Dice Roller

> A fun, multi-player dice game built with Flutter — inspired by classic Ludo board game mechanics.

---

## Overview

**Dice Roller** is a polished, lightweight mobile app that simulates realistic dice rolling for 2–6 players. It features a Ludo-style player turn system with colour-coded indicators, smooth animations, sound effects, and a fully customisable settings panel. The app stores all preferences locally — no account or internet connection required to play.

| | |
|---|---|
| **Package ID** | `com.sulemangul.dice_roller` |
| **Version** | 1.0.1 (build 3) |
| **Platform** | Android · iOS |
| **Framework** | Flutter (Dart SDK ^3.10.4) |
| **Developer** | Suleman Gul · `gullsuleman524@gmail.com` |
| **Privacy Policy** | [View Policy](https://github.com/Gul524/Private-Polices/blob/main/Dice%20Roller) |

---

## Features

### 🎲 Core Gameplay
- **1 – 4 active dice** — add or remove dice on the fly during a session
- **2 – 6 players** — each player gets a unique Ludo-style colour
- **All-6s Bonus Turn** — when every active die shows 6, the current player gets an extra roll (configurable 1–5 consecutive bonus turns before the turn passes)
- **Automatic turn progression** — the board highlights the active player's colour after every roll

### 🎨 Visual Design
- iOS-inspired clean UI with full **Dark / Light / System** theme support
- Per-player colour palette (Green · Yellow · Orange · Blue · Purple · Red) matched to Ludo conventions
- Smooth 3D dice roll animation powered by `flutter_animate`
- Animated player badge with colour glow on the active player

### ⚙️ Settings & Customisation
| Setting | Options |
|---|---|
| Sound Effects | On / Off |
| Color Effects (player turns) | On / Off |
| Theme Mode | System · Light · Dark |
| Number of Players | 2 · 3 · 4 · 5 · 6 |
| Dice Size | S · M · L · XL |
| Dice Limit | 1 – 4 dice |
| All-6s Bonus Limit | 1 – 5 consecutive rolls |

### 📱 Screens
| Screen | Description |
|---|---|
| Splash | Animated logo with bounce effect |
| Home | Main dice board with bottom navigation |
| Settings | Full customisation panel with live colour preview |
| Privacy Policy | In-app policy viewer |
| Privacy Policy (Online) | Opens full policy in system browser (`url_launcher`) |

---

## Project Structure

```
dice_roller2/
├── android/                   Android native project
├── ios/                       iOS native project
├── assets/
│   ├── audio/sound.mp3        Dice roll sound effect
│   └── logo.png               App icon source
├── marketing/
│   └── playstore_feature_graphic.png
├── lib/
│   ├── main.dart              App entry point + Provider setup
│   ├── config/
│   │   ├── app_colors.dart    Colour palette & Ludo player colours
│   │   ├── app_sizes.dart     Spacing / icon / dice size constants
│   │   ├── app_theme.dart     MaterialApp theme (light & dark)
│   │   └── app_info.dart      Developer constants, version helper
│   ├── models/
│   │   └── app_settings.dart  ChangeNotifier — all game state & prefs
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── home_screen.dart
│   │   ├── settings_screen.dart
│   │   └── privacy_policy_screen.dart
│   └── widgets/
│       └── dice_widget.dart   Reusable animated dice component
├── PRIVACY_POLICY.md
├── PLAYSTORE_COMPLIANCE.md    ← Play Store policy checklist
└── pubspec.yaml
```

---

## Getting Started

### Prerequisites
- Flutter SDK ≥ 3.10.4
- Dart SDK ≥ 3.0
- Android Studio / VS Code with Flutter plugin

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/Gul524/dice_roller2.git
cd dice_roller2

# 2. Install dependencies
flutter pub get

# 3. Run on a connected device / emulator
flutter run

# 4. Build a release APK
flutter build apk --release

# 5. Build an App Bundle for Play Store
flutter build appbundle --release
```

### Signing (Android)

Release signing is configured via `android/key.properties`:

```properties
storePassword=<your-keystore-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=<path-to-keystore.jks>
```

> ⚠️ Never commit `key.properties` or the keystore file to version control.

---

## Dependencies

| Package | Version | Purpose |
|---|---|---|
| `provider` | ^6.1.2 | State management (`ChangeNotifier`) |
| `shared_preferences` | ^2.3.4 | Persist settings locally |
| `audioplayers` | ^6.6.0 | Dice roll sound playback |
| `flutter_animate` | ^4.5.0 | Smooth dice & UI animations |
| `package_info_plus` | ^8.3.0 | App version display |
| `upgrader` | ^11.5.0 | In-app update prompts |
| `url_launcher` | ^6.3.0 | Open privacy policy / email links |
| `flutter_launcher_icons` | ^0.14.4 | Generate app icons |

---

## Player Colour System

Each player count uses a carefully chosen Ludo-inspired palette:

| Players | P1 | P2 | P3 | P4 | P5 | P6 |
|---|---|---|---|---|---|---|
| 2 | 🟢 Green | 🔵 Blue | | | | |
| 3 | 🟢 Green | 🟠 Orange | 🟣 Purple | | | |
| 4 | 🟢 Green | 🟡 Yellow | 🔵 Blue | 🔴 Red | | |
| 5 | 🟢 Green | 🟡 Yellow | 🟠 Orange | 🔵 Blue | 🔴 Red | |
| 6 | 🟢 Green | 🟡 Yellow | 🟠 Orange | 🔵 Blue | 🟣 Purple | 🔴 Red |

---

## How to Play

1. Open the app — the Home screen shows the dice board.
2. Tap **Roll** (centre play button) to roll all active dice.
3. If all dice show **6**, you get a bonus roll (up to your configured limit).
4. After a non-6 roll (or reaching the bonus limit), the turn passes to the next player — the board colour changes accordingly.
5. Tap **+** / **−** at the top to add or remove a die.
6. Tap **Settings** to customise players, dice, and appearance.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Sound not playing | Ensure `assets/audio/sound.mp3` exists and sound is enabled in Settings |
| Build failure | Run `flutter clean && flutter pub get` then retry |
| Icons not generated | Run `dart run flutter_launcher_icons` |
| Update prompt always showing | Check `upgrader` config in `main.dart` |

---

## Privacy & Data

- **No personal data collected** — all preferences are stored on-device via `SharedPreferences`.
- **No ads, no analytics, no tracking**.
- **No permissions required** (no camera, microphone, location, contacts, or SMS).
- Full privacy policy: [`PRIVACY_POLICY.md`](./PRIVACY_POLICY.md) · [Online version](https://github.com/Gul524/Private-Polices/blob/main/Dice%20Roller)

### External Link Handling (Google Play compliant)

All outbound links in the app (`url_launcher ^6.3.0`) follow these rules:

| Rule | Implementation |
|---|---|
| Guard check | `canLaunchUrl(uri)` called before every `launchUrl()` |
| Launch mode | `LaunchMode.externalApplication` — opens system browser / mail app, never an in-app WebView |
| `mailto:` encoding | `Uri(queryParameters: {'subject': '...'})` — RFC 6068 compliant |
| Error fallback | `SnackBar` with raw URL / email shown when launch fails |
| Post-dispose safety | `context.mounted` check before showing `SnackBar` |
| Privacy Policy | Accessible both in-app (`PrivacyPolicyScreen`) and via system browser (Settings → Privacy Policy (Online)) |

---

## License

This project is provided for educational and personal use. All rights reserved by the developer.

---

**Enjoy your dice rolling! 🎲**
