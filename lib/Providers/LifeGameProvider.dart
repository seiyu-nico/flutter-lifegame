// Dart imports:
import 'dart:io';
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/iterables.dart';

class LifeGame extends ChangeNotifier {
  LifeGame() : super();

  bool _isRun = false;
  final int _length = 100;
  List<List<bool>> _world = [];

  List<List<bool>> get world => _world;
  int get length => _length;
  void setRun(bool state) => _isRun = state;
  void reset() {
    create();
    notifyListeners();
  }

  void create() {
    var rand = math.Random();
    _world = List.generate(
        _length,
        (_) => List.generate(
            _length, (_) => rand.nextDouble() > 0.3 ? false : true));
  }

  void next() async {
    while (_isRun) {
      List<List<bool>> nextWorld =
          List.generate(_length, (_) => List.generate(_length, (_) => false));
      for (int y = 0; y < _length; y++) {
        for (int x = 0; x < _length; x++) {
          nextWorld[y][x] = calcNext(_length, y, x) == 1 ? true : false;
        }
      }

      _world = nextWorld;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  int calcNext(int length, int y, int x) {
    int aroundLife = 0;
    for (final i in range(y - 1, y + 2)) {
      for (final j in range(x - 1, x + 2)) {
        aroundLife += _world[((i + length) % length).toInt()]
                [((j + length) % length).toInt()]
            ? 1
            : 0;
      }
    }
    aroundLife -= _world[y][x] ? 1 : 0;
    switch (aroundLife) {
      case 3:
        return 1;
      case 2:
        return _world[y][x] ? 1 : 0;
      default:
        return 0;
    }
  }
}

final lifeGameProvider = ChangeNotifierProvider<LifeGame>((ref) {
  return LifeGame();
});
