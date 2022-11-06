// Dart imports:
import 'dart:io';
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiver/iterables.dart';

// Project imports:
import './Providers/LifeGameProvider.dart';
import './world.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LifeGame lifeGame = ref.read(lifeGameProvider);
    lifeGame.create();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ライフゲーム'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const World(),
            Container(
              height: 150,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
