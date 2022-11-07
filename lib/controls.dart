// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'providers/life_game_provider.dart';

class Controls extends ConsumerWidget {
  Controls({Key? key}) : super(key: key);

  final _lengthController = TextEditingController();
  static const String labelText =
      '${LifeGame.minLength} ~ ${LifeGame.maxLength}の値を入力してください';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _lengthController.text = LifeGame.defaultLength.toString();
    return Container(
      height: 150,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Consumer(builder: (context, ref, _) {
              LifeGame lifeGame = ref.read(lifeGameProvider);
              return TextFormField(
                decoration: const InputDecoration(labelText: labelText),
                controller: _lengthController,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                      if (!(LifeGame.minLength <= int.parse(newValue.text) &&
                          int.parse(newValue.text) <= LifeGame.maxLength)) {
                        newValue = oldValue;
                        showSnackBar(context);
                      }
                      return newValue;
                    },
                  ),
                ],
                onChanged: (value) {
                  lifeGame.setLength(int.parse(value));
                },
              );
            }),
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
                        if (lifeGame.isRun) {
                          return;
                        }
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

  void showSnackBar(context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(labelText),
        action: SnackBarAction(
          label: 'とじる',
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
