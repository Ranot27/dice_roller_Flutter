import 'package:dice_roller/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class StartingPage extends StatelessWidget {
  StartingPage({super.key});

  @override
  Widget build(BuildContext context) {

    final dices = Provider.of<DiceRollModel>(context).dices;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const RollNumberBar(),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (i) => DiceTile(dices[i])),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Theme.of(context).colorScheme.background,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SecondScreen()));
        },
        style: const ButtonStyle(elevation: WidgetStatePropertyAll(10.0)),
        child: const Text("История бросков"),
      ),
    );
  }
}

class RollNumberBar extends StatefulWidget {
  const RollNumberBar({super.key});

  @override
  State<RollNumberBar> createState() => _RollNumberBarState();
}

class _RollNumberBarState extends State<RollNumberBar> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<DiceRollModel>(context);
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
                        model.decrease();
                      },
                      onLongPress: () {
                        model.reset();
                      },
                      child: const Icon(Icons.exposure_minus_1)),
                  Text('Количество бросков: ${model.numberOfRolls}'),
                  ElevatedButton(
                      onPressed: () {
                        model.increase();
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
          var rolls = rollResult(Provider.of<DiceRollModel>(context, listen: false).numberOfRolls);
          _dialog(context, rolls);
          Provider.of<DiceRollModel>(context, listen: false).addInAllRolls(diceNumber: dice.number, rolls: rolls);
        },
      ),
    );
  }

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

  List<int> rollResult(int numberOfRolls) {
    var result = 0;
    List<int> rolls = [];
    var rollsString = '';
    for (int i = 0; i < numberOfRolls; i++) {
      var r = dice.rollDice();
      result += r;
      rolls.add(r);
      rollsString += "$r ";
    }
    return rolls;
  }
}
