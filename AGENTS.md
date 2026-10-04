# Mindra

Flutter iOS-first emotion-reflection app (Vietnamese UI). In-memory `MindraState` + mock seed data. No backend, no persistence, no real AI API.

Product intent: `MINDRA_PRODUCT_SPEC.md`. Implemented UI: `lib/`.

## Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter test test/widget_test.dart
```

SDK `^3.13.3`. Analyzer excludes `android/`, `ios/`, `macos/`, `web/`, `build/`. Theme uses `google_fonts` (Plus Jakarta Sans); widget tests can fail offline if fonts are not cached.

## Layout (trust code, not docs)

Bottom nav is **four tabs** in `HomeShell`:

0. Hôm nay (`TodayView`)
1. Nhật ký (`JournalView`)
2. Khu vườn (`GardenView`)
3. Khám phá (`ExploreView` → inner switcher: Tiến trình / Thực hành)

Settings is **not a tab**. Open via app-bar **Tôi**. Check-in and Pause Mode are sheets/modals from Today.

Stale sources (do not follow for IA):

- Root `README.md` (old HTML prototype; live HTML is `prototype/`)
- Spec §6 (lists Settings as a tab; Garden is not in that list)
- `.agents/rules/ui_ux_guidelines.md` (claims 5 tabs including Thực hành / Bạn)

Keep 44pt touch targets, Vietnamese copy, non-clinical tone. Do not add diagnosis, crisis-service claims, social, subscriptions, or wearables.

## App wiring

- Entry: `lib/main.dart` → `ChangeNotifierProvider<MindraState>` → onboarding / app lock / `HomeShell`
- Default state: `onboardingCompleted = true`, `isAuthenticated = true`, `appLockEnabled = false`, entries from `MockData.getInitialEntries()`. Pumping `MindraApp` in tests lands on `HomeShell`.
- Demo personas: `MindraState.applyDemoScenario` (`firstLaunch` / `returning` / `active`)
- “AI” reflection is local templates + Vietnamese/English crisis keyword flag in `AIReflection.forEmotion`. Not a network call.

## Tests

`test/widget_test.dart` is the behavior contract. Layout is asserted at **320×800** (and garden at 375/430). Prefer `ValueKey`s already used (Vietnamese field labels, `garden-flower-<entryId>`). Garden is moments planted from entries, grouped by month (20 slots/bed), not one flower per emotion. AI reflection tests wait ~2s for the fake generate delay. After UI changes, run `flutter analyze` then `flutter test`.
