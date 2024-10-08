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
        buildWhen: (previous, current) =>
            previous.themeMode != current.themeMode ||
            previous.colorSeed != current.colorSeed ||
            previous.locale != current.locale,
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: state.colorSeed ?? Colors.redAccent,
              ),
              appBarTheme: const AppBarTheme(centerTitle: true),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: state.colorSeed ?? Colors.redAccent,
                brightness: Brightness.dark,
              ),
              appBarTheme: const AppBarTheme(centerTitle: true),
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
