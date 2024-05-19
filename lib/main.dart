import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rec_music/prefs.dart';
import 'package:rec_music/screens/home_screen.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFFFF2E1),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFA79277),
          ),
        ),
        cardColor: const Color(0xFFEAD8C0),
      ),
      home: const HomeScreen(),
    );
  }
}
