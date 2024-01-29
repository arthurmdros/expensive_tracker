import 'package:expensive_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(93, 21, 12, 120));

var kColorSchemeDark = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  brightness: Brightness.dark,
);

void main() {
  //USED TO DEFINE ONLY ONE MODE ROTATION
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(
      const ExpenseTracker(),
    );
  });
}

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseTracker();
  }
}

class _ExpenseTracker extends State<ExpenseTracker> {
  var _themeMode = ThemeMode.system;

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kColorSchemeDark,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchemeDark.inversePrimary,
          foregroundColor: kColorSchemeDark.onPrimaryContainer,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorSchemeDark.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeDark.primaryContainer,
              foregroundColor: kColorSchemeDark.onPrimaryContainer),
        ),
        // textTheme: ThemeData().textTheme.copyWith(
        //       titleLarge: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: kColorScheme.primary,
        //         fontSize: 16,
        //       ),
        //     ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        // textTheme: ThemeData().textTheme.copyWith(
        //       titleLarge: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: kColorScheme.primary,
        //         fontSize: 16,
        //       ),
        //     ),
      ),
      themeMode: _themeMode, //default
      home: Expenses(changeTheme: changeTheme),
      //TIVE QUE ADICIONAR ESSAS CONFIGS PRA DEIXAR NA LINGUA PORTUGUES O LOCALE
      // ALTEREI O MINSDK NO BUILD-GRADLE DO ANDROID PRA 21 PQ PELO VISTO QUANDO EU CRIO O APP 
      // ELE FICA NO 19 E N CONSIGO USAR O PACOTE
      // DE INTERNACIONALIZAÇÃO, INSTALEI O PACOTE FLUTTER_LOCALIZATION: flutter pub add flutter_localization
      //  E ALTEREI A VERSAO DO intl PARA A VERSÃO ^0.18.1
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('pt_BR'),
      ],
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
