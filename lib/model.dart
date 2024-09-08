import 'dart:math';

import 'package:flutter/cupertino.dart';

class DiceRollModel extends ChangeNotifier {
  int _numberOfRolls = 1;

  int get numberOfRolls => _numberOfRolls;

  void increase() {
    _numberOfRolls++;
    notifyListeners();
  }

  void decrease() {
    if (_numberOfRolls > 1) {
      _numberOfRolls--;
      notifyListeners();
    }
  }

  void reset() {
    _numberOfRolls = 1;
    notifyListeners();
  }

  final List<Dice> dices = const [
    Dice(number: 4, image: 'images/d4.jpg'),
    Dice(number: 6, image: 'images/d6.jpg'),
    Dice(number: 8, image: 'images/d8.jpg'),
    Dice(number: 10, image: 'images/d10.jpg'),
    Dice(number: 12, image: 'images/d12.jpg'),
    Dice(number: 20, image: 'images/d20.jpg'),
  ];


  Map<int, List<int>> _allRolls = {
    4: [],
    6: [],
    8: [],
    10: [],
    12: [],
    20: [],
  };
  List<int> getRolls (int diceNumber) => _allRolls[diceNumber]!;

  void addInAllRolls({required int diceNumber, required List<int> rolls}) {
    _allRolls[diceNumber] = _allRolls[diceNumber]!..addAll(rolls);
    notifyListeners();
  }

  void resetAllRolls() {
    _allRolls[4] = [];
    _allRolls[6] = [];
    _allRolls[8] = [];
    _allRolls[10] = [];
    _allRolls[12] = [];
    _allRolls[20] = [];
    notifyListeners();
  }

}


class Dice {
  final int number;
  final String image;

  const Dice({required this.number, required this.image});

  int rollDice() {
    return (Random().nextInt(number)) + 1;
  }
}
