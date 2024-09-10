import 'package:dice_roller/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// Класс второго окна с историей бросков
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DiceRollsText(diceNumber: 4),
          DiceRollsText(diceNumber: 6),
          DiceRollsText(diceNumber: 8),
          DiceRollsText(diceNumber: 10),
          DiceRollsText(diceNumber: 12),
          DiceRollsText(diceNumber: 20),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("История бросков"),
        actions: [
          ElevatedButton(
            onPressed: () {Provider.of<DiceRollModel>(context, listen: false).resetAllRolls();}, //Кнопка для удаления истории бросков
            child: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}


// Виджет для показа истории бросков по определённому кубику
class DiceRollsText extends StatelessWidget {
  const DiceRollsText({super.key, required this.diceNumber});

  final int diceNumber;

  @override
  Widget build(BuildContext context) {
    var l = 'd$diceNumber'.toString().length.toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50 - l), // Для выравнивания
          child: Text(
            'd$diceNumber',
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Text(makeRollsText(Provider.of<DiceRollModel>(context).getRolls(diceNumber))) //Создаём строку из истории бросков из модели
      ]
    );
  }

  // Функция для создания строки из List<int>
  String makeRollsText(List<int> rolls) {
    var result = '';
    for (int i in rolls) {
      result += '$i ';
    }
    return 'Прошлые броски: $result';
  }
}
