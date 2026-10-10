import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mirrors_admin_app/core/routing/app_router.dart';
import 'package:mirrors_admin_app/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'presentation/manager/app_settings/app_settings_cubit.dart';
import 'presentation/manager/app_settings/app_settings_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();

  runApp(
    BlocProvider(
      create: (_) => AppSettingsCubit(prefs),
      child: const MirrorsAdminApp(),
    ),
  );
}

class MirrorsAdminApp extends StatelessWidget {
  const MirrorsAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Mirrors Admin',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: appRouter,
        );
      },
    );
  }
}