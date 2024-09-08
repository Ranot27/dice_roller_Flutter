import 'dart:math';

import 'package:dice_roller/model.dart';
import 'package:dice_roller/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => DiceRollModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Navigator(
          pages: [
            MaterialPage(
              child: StartingPage(),
            ),
          ],
        ),
      ),
    );
  }
}

