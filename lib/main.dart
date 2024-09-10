import 'package:dice_roller/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

void main() {
  runApp(MyApp());
}

// Класс приложения, создаёт Provider, MaterialApp с начальной страницей - StartingPage
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) {
        var d = DiceRollModel();
        d.loadData(4);   // Загрузка данных модели из памяти устрйоства
        d.loadData(6);   // Уверен, что это сделано неправильно и некрасиво, но как по-другому не знаю
        d.loadData(8);
        d.loadData(10);
        d.loadData(12);
        d.loadData(20);
        return d;
        },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartingPage(),
      ),
    );
  }
}

