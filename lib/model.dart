import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Класс модель всего приложения, содержить всю неоходимую бизнес логику
class DiceRollModel extends ChangeNotifier {
  // Количество бросков
  int _numberOfRolls = 1;
  int get numberOfRolls => _numberOfRolls;

  // Функции для изменения количества бросков
  // TODO: сделать правильные названия
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

  // Список всех кубиков
  final List<Dice> dices = const [
    Dice(number: 4, image: 'images/d4.jpg'),
    Dice(number: 6, image: 'images/d6.jpg'),
    Dice(number: 8, image: 'images/d8.jpg'),
    Dice(number: 10, image: 'images/d10.jpg'),
    Dice(number: 12, image: 'images/d12.jpg'),
    Dice(number: 20, image: 'images/d20.jpg'),
  ];

  // Map хранящий историю всех бросков
  Map<int, List<int>> _allRolls =  {};
  List<int> getRolls (int diceNumber) => _allRolls[diceNumber]!;

  // Функция для добавления брсоков в историю
  void addInAllRolls({required int diceNumber, required List<int> rolls}) {
    _allRolls[diceNumber] = _allRolls[diceNumber]!..addAll(rolls);
    notifyListeners();

    saveData(diceNumber, rolls);
  }
  // Функция для ичищения истории
  // Скорее всего написан криво
  void resetAllRolls() {
    _allRolls[4]!.clear();
    _allRolls[6]!.clear();
    _allRolls[8]!.clear();
    _allRolls[10]!.clear();
    _allRolls[12]!.clear();
    _allRolls[20]!.clear();
    notifyListeners();

    saveData(4, []);
    saveData(6, []);
    saveData(8, []);
    saveData(10, []);
    saveData(12, []);
    saveData(20, []);
  }


  //TODO: скорее всего нужно вынести в отдельную сущность
  // Функция для загрузки истории брлсоков из памяти устройства
  Future<void> loadData(int key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList(key.toString()) ?? [];
    List<int> result = [];
    for (var i in data) {
      result.add(int.parse(i));
    }
    _allRolls[key] = result;
  }
  // Функция для сохранения в памяти устрйоства истории бросков
  Future<void> saveData(int key, List<int> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dataS = [];
    for (var i in data) {
      dataS.add(i.toString());
    }
    prefs.setStringList(key.toString(), dataS);
  }
}

// Класс кубик, хранит информацию о себе и даёт метод для бросания
class Dice {
  final int number;
  final String image;

  const Dice({required this.number, required this.image});

  int rollDice() {
    return (Random().nextInt(number)) + 1;
  }
}



