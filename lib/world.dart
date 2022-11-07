// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'providers/life_game_provider.dart';

class World extends ConsumerWidget {
  const World({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LifeGame lifeGame = ref.read(lifeGameProvider);
    lifeGame.create();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Consumer(
          builder: (context, ref, _) {
            LifeGame lifeGame = ref.watch(lifeGameProvider);
            return Column(
              children: List.generate(
                lifeGame.length,
                (int y) => Expanded(
                  child: Row(
                    children: List.generate(
                      lifeGame.length,
                      (int x) => Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: lifeGame.world[y][x]
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
