# Google Play Store Compliance Checklist
### Dice Roller — `com.sulemangul.dice_roller`

> Use this checklist before every Play Store submission.  
> Reference: [Google Play Developer Policy Centre](https://play.google.com/about/developer-content-policy/)

---

## How to Use This File
- `[ ]` — Not yet done / needs review  
- `[x]` — Confirmed compliant  
- `[!]` — Action required / blocker  

---

## 1. App Content & Metadata

### 1.1 Store Listing
- [x] App **title** is accurate and non-misleading (`Dice Roller`)
- [x] **Short description** (≤80 chars) describes the app accurately
- [x] **Full description** does not contain spam, keyword stuffing, or misleading claims
- [x] Screenshots represent **actual app UI** — no fake device frames with unrelated content
- [x] Feature graphic (`marketing/playstore_feature_graphic.png`) does not contain prohibited imagery
- [x] App icon does not imitate system icons, other apps, or Google/Play Store branding
- [ ] **Content rating questionnaire** completed in Play Console (IARC rating obtained)
- [x] App category set correctly (`Games → Casual` or `Entertainment`)
- [x] Contact email (`gullsuleman524@gmail.com`) is active and reachable

### 1.2 App Functionality
- [x] App launches without crashing on cold start
- [x] App works correctly on Android 5.0+ (API 21+)
- [x] App does not contain broken links or dead placeholder screens
- [x] In-app Privacy Policy screen (`PrivacyPolicyScreen`) is accessible and loads correctly
- [x] Settings persist across app restarts (SharedPreferences)
- [x] No crash on rapid repeated dice rolls
- [ ] Tested on **at least 3 different device/screen sizes** (phone small, phone large, tablet)
- [ ] Tested on **Android 13+** for new permission model behaviour
- [ ] Tested on **Android 5 / 6** for minimum SDK compatibility

### 1.3 External URL & Deep-Link Handling
- [x] All external URL launches use `canLaunchUrl()` guard before calling `launchUrl()`
- [x] All web URLs use `LaunchMode.externalApplication` (opens system browser, not in-app WebView)
- [x] `mailto:` URI built with `Uri(queryParameters: {...})` — RFC 6068 compliant encoding
- [x] `mailto:` URI uses `LaunchMode.externalApplication` for broadest device compatibility
- [x] Every launch failure shows a user-friendly `SnackBar` with the raw URL / email as fallback
- [x] `SnackBar` is only shown if `context.mounted` is still true (prevents post-dispose exceptions)
- [x] `SnackBar` uses `SnackBarBehavior.floating` and a 4-second duration for readability
- [x] Privacy Policy accessible both in-app (`PrivacyPolicyScreen`) and via external browser link
- [x] External Privacy Policy URL (`AppInfo.privacyPolicyUrl`) is publicly accessible without login
> ✅ Compliant with Google Play [App Functionality requirements](https://play.google.com/about/developer-content-policy/) and
> Android [`url_launcher`](https://pub.dev/packages/url_launcher) best practices.

---

## 2. Privacy & Data Safety

### 2.1 Privacy Policy
- [x] Privacy policy URL provided in Play Console: `https://github.com/Gul524/Private-Polices/blob/main/Dice%20Roller`
- [x] Privacy policy is **publicly accessible** (no login required)
- [x] Privacy policy accurately describes what data is collected (only local SharedPreferences)
- [x] Privacy policy mentions all third-party SDKs (`upgrader`, `audioplayers`, `package_info_plus`)
- [x] Privacy policy includes **contact information** (developer name + email)
- [x] Privacy policy has an **effective date** (March 25, 2026)
- [ ] Privacy policy URL is also linked from within the app's store listing page

### 2.2 Data Safety Section (Play Console)
- [ ] **Data Safety form** completed in Play Console → App Content → Data Safety
- [ ] Declared: **No personal data collected**
- [ ] Declared: **No data shared with third parties** for advertising
- [ ] Declared: Data is **not encrypted in transit** (local prefs only — mark N/A)
- [ ] Declared: Users **can delete data** by uninstalling the app
- [ ] `upgrader` package network call (version check) — declare as **App functionality**, not advertising
- [ ] Data Safety answers match the claims in `PRIVACY_POLICY.md`

### 2.3 Permissions
- [x] `INTERNET` permission — used only by `upgrader` for update checks (acceptable)
- [x] No `READ_CONTACTS`, `CAMERA`, `RECORD_AUDIO`, `ACCESS_FINE_LOCATION`, or `READ_SMS`
- [x] No permissions requested that are not needed for core functionality
- [ ] Verify `AndroidManifest.xml` contains **no unused permissions** from transitive dependencies

---

## 3. Restricted Content

### 3.1 Gambling Policy
- [x] App does **not** simulate real-money gambling
- [x] App does **not** offer real prizes, tokens, or in-app purchases tied to dice outcomes
- [x] App does **not** facilitate betting between users
- [x] App is a **utility/entertainment tool** only — dice rolling for board games
- [x] No casino-style themes, chips, cards, or slot imagery
> ✅ This app is compliant with Google's [Real-Money Gambling policy](https://support.google.com/googleplay/android-developer/answer/9877778).

### 3.2 Ads Policy
- [x] App contains **no advertisements**
- [x] No Ad SDKs integrated (no AdMob, Meta Audience Network, etc.)
> ✅ No ad compliance requirements apply.

### 3.3 In-App Purchases
- [x] App contains **no in-app purchases**
- [x] No billing library integrated
- [x] No "premium" features locked behind payment
> ✅ No billing compliance requirements apply.

### 3.4 Children & Families
- [x] App does not specifically target children under 13
- [x] No social features, chat, or user-generated content
- [x] No collection of personal data from children
- [ ] If targeting "Everyone" (which includes under-13), verify COPPA compliance — no data collection confirmed ✅
- [ ] If submitting to **Designed for Families** programme — additional review needed (not currently planned)

### 3.5 User-Generated Content (UGC)
- [x] App contains **no user-generated content**
- [x] No social sharing, commenting, or community features
> ✅ No UGC policy requirements apply.

### 3.6 Deceptive Behaviour
- [x] App does **not** impersonate another app or developer
- [x] App does **not** redirect users to external stores or payment flows
- [x] `upgrader` shows a standard in-app dialog — does not bypass Play Store update mechanism
- [x] App name matches the actual functionality

---

## 4. Technical Requirements

### 4.1 Target SDK & Build
- [ ] `targetSdkVersion` ≥ **35** (required for new apps from Aug 2024; existing apps check current requirement)
- [ ] `minSdkVersion` ≥ **21** (Android 5.0) — confirmed in `build.gradle`
- [ ] App Bundle (`.aab`) used for submission (not bare `.apk`)
- [ ] Release build signed with a **dedicated release keystore** (not the debug key)
- [x] Keystore file and `key.properties` are **not committed** to version control
- [ ] `android:debuggable` is `false` in the release manifest
- [ ] ProGuard / R8 shrinking tested — no class-not-found runtime errors

### 4.2 64-bit Support
- [ ] App supports **64-bit ABI** (`arm64-v8a`) — Flutter supports this by default
- [ ] Verify with: `flutter build appbundle` → check AAB contains `arm64-v8a` libs

### 4.3 App Stability
- [ ] No ANRs (Application Not Responding) on main thread
- [ ] Dice roll animation does not block the UI thread
- [ ] App handles device rotation gracefully (or locks to portrait if intentional)
- [ ] App handles audio focus correctly (pauses on call, etc.)
- [ ] Background → foreground resume works without losing state

### 4.4 Network & Security
- [ ] No HTTP (plain text) network calls — `upgrader` uses HTTPS ✅
- [ ] `android:usesCleartextTraffic` is `false` in release (or omitted, defaults to false on API 28+)
- [ ] No sensitive data (keys, tokens) hardcoded in source code

---

## 5. Play Console Requirements

### 5.1 App Content Declaration (App Content section)
- [ ] **Privacy Policy** URL entered in Play Console
- [ ] **Ads** declaration: "This app does not contain ads" — selected
- [ ] **Content rating** questionnaire completed → IARC rating received
- [ ] **Target audience and content** form completed
- [ ] **Data Safety** form completed and published
- [ ] **App access** section filled (if any login/restricted areas — N/A for this app)
- [ ] **Financial features** declaration: None
- [ ] **Health** declaration: None
- [ ] **Government apps** declaration: None

### 5.2 Release Track
- [ ] Tested on **Internal Testing** track first
- [ ] Promoted to **Closed Testing (Alpha)** if needed
- [ ] Promoted to **Open Testing (Beta)** if needed
- [ ] **Production** rollout done with staged rollout (e.g. 20% → 50% → 100%)

### 5.3 Store Listing Assets
| Asset | Size | Status |
|---|---|---|
| App icon | 512×512 PNG | [ ] |
| Feature graphic | 1024×500 PNG | [x] (`marketing/playstore_feature_graphic.png`) |
| Phone screenshots | min 2, max 8 | [ ] |
| 7-inch tablet screenshots | optional but recommended | [ ] |
| 10-inch tablet screenshots | optional but recommended | [ ] |
| Short description | ≤80 chars | [ ] |
| Full description | ≤4000 chars | [ ] |

---

## 6. Post-Launch Monitoring

- [ ] **Play Console → Android Vitals** — monitor crash rate (target <1.09%)
- [ ] **ANR rate** monitored (target <0.47%)
- [ ] **User reviews** responded to within 48 hours
- [ ] **Policy violation emails** from Google monitored and acted on within 7 days
- [ ] Privacy policy URL kept **live** and accurate after any SDK changes
- [ ] If adding ads/IAP in future — **re-complete** Data Safety form before release

---

## 7. Quick Pre-Submit Checklist

Run through this before every new version submission:

```
[ ] flutter clean && flutter pub get
[ ] flutter build appbundle --release
[ ] Install & smoke-test the release AAB on a physical device
[ ] App title, icon, and description are unchanged (or update store listing)
[ ] No new permissions added without updating Privacy Policy & Data Safety
[ ] Version code incremented in pubspec.yaml
[ ] Keystore used is the PRODUCTION keystore (not debug)
[ ] CHANGELOG / release notes written for Play Console (500 chars max)
[ ] Staged rollout configured (start at 20%)
```

---

## References

- [Google Play Developer Policy Centre](https://play.google.com/about/developer-content-policy/)
- [Target API level requirements](https://support.google.com/googleplay/android-developer/answer/11926878)
- [Data Safety section guide](https://support.google.com/googleplay/android-developer/answer/10787469)
- [App content declarations](https://support.google.com/googleplay/android-developer/answer/9859455)
- [Real-money gambling policy](https://support.google.com/googleplay/android-developer/answer/9877778)
- [Families policy](https://support.google.com/googleplay/android-developer/answer/9893335)
- [IARC content rating](https://support.google.com/googleplay/android-developer/answer/188189)

---

*Last updated: June 2026 — review before each major release. External URL handling updated June 2026.*
