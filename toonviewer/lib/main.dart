import 'package:flutter/material.dart';
import 'package:toonviewer/screens/home_screen_for_toonviewer.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
