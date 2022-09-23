import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/gen/l10n/res.dart';
import 'package:flutter_clean_architecture/src/core/config/themes.dart';
import 'package:flutter_clean_architecture/src/modules/app/bloc/language_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LanguageBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Clean Architecture Flutter',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      localizationsDelegates: Resource.localizationsDelegates,
      supportedLocales: Resource.supportedLocales,
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        if (supportedLocales.any((element) =>
            locale?.languageCode.contains(element.toString()) == true)) {
          return locale;
        }
        return const Locale('en', '');
      },
    );
  }
}
