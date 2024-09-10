import 'package:dice_roller/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

// Класс начальной страницы
class StartingPage extends StatelessWidget {
  StartingPage({super.key});

  @override
  Widget build(BuildContext context) {

    final dices = Provider.of<DiceRollModel>(context).dices; // Из модели достаю список кубиков

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const RollNumberBar(), //Закидываю в flexibleSpace, чтобы сделать её кастомной
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (i) => DiceTile(dices[i])),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// Класс с кнопкой для перехода на второй экран с историей бросков
class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0, // Чтобы цвет фона был как у остальной части экрана
      color: Theme.of(context).colorScheme.surface,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecondScreen())); // Переход на второй экран с помощью Navigator 1.0
        },
        style: const ButtonStyle(elevation: WidgetStatePropertyAll(10.0)),
        child: const Text("История бросков"),
      ),
    );
  }
}


//Класс AppBar c текстом и кнопками для изменения количества бросков
class RollNumberBar extends StatefulWidget {
  const RollNumberBar({super.key});

  @override
  State<RollNumberBar> createState() => _RollNumberBarState();
}

class _RollNumberBarState extends State<RollNumberBar> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<DiceRollModel>(context); // Берём модель из Provider
    return SafeArea(
      child: Column(
        children: [
          const Text("DnD dices"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        model.decrease(); // По нажатию уменьшаем количество бросков в модели на 1
                      },
                      onLongPress: () {
                        model.reset(); // При долгом нажатии уменьшаем количество бросков до 1
                      },
                      child: const Icon(Icons.exposure_minus_1)),
                  Text('Количество бросков: ${model.numberOfRolls}'),
                  ElevatedButton(
                      onPressed: () {
                        model.increase(); // По нажатию увеличиваем количество бросков в модели на 1
                      },
                      child: const Icon(Icons.plus_one)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//Класс виджета в виде кубика, дающий сделать бросок по нажатию
class DiceTile extends StatelessWidget {
  const DiceTile(this.dice, {super.key});

  final Dice dice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        child: Image.asset(dice.image),
        onTap: () {
          var rolls = rollResult(Provider.of<DiceRollModel>(context, listen: false).numberOfRolls); // Получаем список бросков
          _dialog(context, rolls); // Создаём диалог с результатом бросков
          Provider.of<DiceRollModel>(context, listen: false).addInAllRolls(diceNumber: dice.number, rolls: rolls); // Записываем броски в модель
        },
      ),
    );
  }

  //Асинхронная функция для создания диалогово окна с результатами броска
  Future<void> _dialog(BuildContext context, List<int> rolls) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Result:"),
            content: Text(makeDialogText(rolls)),
            actions: <Widget>[
              TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Спасибо!"))
            ],
          );
        });
  }

  // Функция для создания текста для диалогового окна
  String makeDialogText(List<int> rolls) {
    var result = '';
    var sum = 0;
    if (rolls.length == 1) {
      return 'Результат: ${rolls[0]}';
    } else {
      for (int i in rolls) {
        sum += i;
        result += '$i ';
      }
    }
    return "Сумма: $sum \nБроски: $result";
  }


  // Функцию, делающая броски
  List<int> rollResult(int numberOfRolls) {
    List<int> rolls = [];
    for (int i = 0; i < numberOfRolls; i++) {
      var r = dice.rollDice();
      rolls.add(r);
    }
    return rolls;
  }
}
