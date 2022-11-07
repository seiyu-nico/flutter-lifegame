// Dart imports:
import 'dart:math' as math;

class Rules {
  static List<List<bool>> random(length) {
    var rand = math.Random();
    return List.generate(
        length,
        (_) => List.generate(
            length, (_) => rand.nextDouble() < 0.3 ? true : false));
  }

  static List<List<bool>> cross(length) => List.generate(
      length,
      (y) => List.generate(
          length, (x) => x == y || x + y + 1 == length ? true : false));
}
