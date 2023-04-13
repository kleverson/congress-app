import 'package:congress/core/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:congress/screen/home_screen.dart';

void main() {
  runApp(const CongressApp());
}

class CongressApp extends StatelessWidget {
  const CongressApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Congresso info',
      theme: AppTheme(context).defaultTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}
