import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_01/app_project_IOT/pages/home.dart';
import 'package:project_01/express_app/pages/expreses.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

  await ref.set({
    "name": "John",
    "age": 18,
    "address": {"line1": "100 Mountain View"}
  });
  runApp(const MyIOT());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var kColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 96, 59, 181),
    );
    var kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 5, 99, 125),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(kDarkColorScheme.primaryContainer),
            foregroundColor: MaterialStatePropertyAll(
              kDarkColorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      theme: ThemeData(useMaterial3: true).copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(kColorScheme.primaryContainer),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      home: const Expenses(),
    );
  }
}

class MyIOT extends StatelessWidget {
  const MyIOT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
