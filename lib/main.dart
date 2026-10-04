import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme.dart';
import 'state/mindra_state.dart';
import 'screens/app_lock_view.dart';
import 'screens/home_shell.dart';
import 'screens/onboarding_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MindraApp());
}

class MindraApp extends StatefulWidget {
  const MindraApp({super.key});

  @override
  State<MindraApp> createState() => _MindraAppState();
}

class _MindraAppState extends State<MindraApp> {
  bool _unlockedThisSession = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MindraState(),
      child: Consumer<MindraState>(
        builder: (context, state, _) {
          Widget home;
          if (!(state.onboardingCompleted && state.isAuthenticated)) {
            home = const OnboardingView();
          } else if (state.appLockEnabled && !_unlockedThisSession) {
            home = AppLockView(
              state: state,
              onUnlocked: () => setState(() => _unlockedThisSession = true),
            );
          } else {
            home = const HomeShell();
          }

          return MaterialApp(
            title: 'Mindra',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: home,
          );
        },
      ),
    );
  }
}
