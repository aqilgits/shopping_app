import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/wrapper.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ScreenWrapper(),
    );
  }
}
