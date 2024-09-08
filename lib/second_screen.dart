import 'package:dice_roller/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        children: [
          DiceRollsText(diceNumber: 4),
          DiceRollsText(diceNumber: 6),
          DiceRollsText(diceNumber: 8),
          DiceRollsText(diceNumber: 10),
          DiceRollsText(diceNumber: 12),
          DiceRollsText(diceNumber: 20),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("История бросков"),
        actions: [
          ElevatedButton(
            onPressed: () {Provider.of<DiceRollModel>(context).resetAllRolls();},
            child: Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}

class DiceRollsText extends StatelessWidget {
  const DiceRollsText({super.key, required this.diceNumber});

  final int diceNumber;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'd$diceNumber',
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
      Text(makeRollsText(
          Provider.of<DiceRollModel>(context).getRolls(diceNumber)))
    ]);
  }

  String makeRollsText(List<int> rolls) {
    var result = '';
    for (int i in rolls) {
      result += '$i ';
    }
    return 'Прошлые броски: $result';
  }
}
