import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import './Providers/LifeGameProvider.dart';

class Controls extends ConsumerWidget {
  Controls({Key? key}) : super(key: key);

  final _lengthController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LifeGame lifeGame = ref.read(lifeGameProvider);
    _lengthController.text = lifeGame.defaultLength.toString();
    return Container(
      height: 150,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Consumer(builder: (context, ref, _) {
                  LifeGame lifeGame = ref.read(lifeGameProvider);
                  return TextFormField(
                    decoration: const InputDecoration(hintText: "10 ~ 100"),
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (!(0 <= int.parse(value) && int.parse(value) <= 100)) {
                        _lengthController.text =
                            lifeGame.defaultLength.toString();
                        return;
                      }
                      lifeGame.setLength(int.parse(value));
                    },
                  );
                }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(
                  builder: (context, ref, _) {
                    LifeGame lifeGame = ref.read(lifeGameProvider);
                    return ElevatedButton(
                      onPressed: () {
                        lifeGame.setRun(true);
                        lifeGame.next();
                      },
                      child: const Text('start'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(
                  builder: (context, ref, _) {
                    LifeGame lifeGame = ref.read(lifeGameProvider);
                    return ElevatedButton(
                      onPressed: () {
                        lifeGame.setRun(false);
                      },
                      child: const Text('stop'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(
                  builder: (context, ref, _) {
                    LifeGame lifeGame = ref.read(lifeGameProvider);
                    return ElevatedButton(
                      onPressed: () {
                        lifeGame.reset();
                      },
                      child: const Text('reset'),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
