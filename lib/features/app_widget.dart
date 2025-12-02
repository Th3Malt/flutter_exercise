import 'package:flutter/material.dart';

import '../core/core_imports.dart';
import 'features_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InteractiveCardPage(),
      theme: ThemeData(fontFamily: FontFamily.AktivGrotesk.name),
    );
  }
}
