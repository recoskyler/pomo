import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/l10n/l10n.dart';
import 'package:pomo/pages/about/view/about_page.dart';
import 'package:pomo/pages/deniz/deniz.dart';
import 'package:pomo/pages/settings/settings.dart';
import 'package:pomo/pages/timer/timer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerCubit>(
          create: (context) => TimerCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit()..loadSettings(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.redAccent,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.redAccent,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: state.themeMode,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: S.localizationsDelegates,
            supportedLocales: S.supportedLocales,
            routes: {
              '/': (context) => const TimerPage(),
              '/settings': (context) => const SettingsPage(),
              '/about': (context) => const AboutPage(),
              '/deniz': (context) => const DenizPage(),
            },
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
