import 'dart:ffi';

import 'package:flutter/material.dart';

class GameSetup extends StatefulWidget {
  const GameSetup({Key? key}) : super(key: key);

  @override
  State<GameSetup> createState() => _GameSetupState();
}

class _GameSetupState extends State<GameSetup> {
  final playerNames = _PlayerNames();

  @override
  Widget build(BuildContext context) {
    _submit() {}

    final addPlayerButton = OutlinedButton(
        onPressed: () {
          setState(() {
            playerNames.add();
          });
        },
        child: const Icon(Icons.add));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Setup'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _submit, child: const Icon(Icons.done)),
      body: Center(
          child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (playerNames.toListView()),
            Expanded(flex: 1, child: Center(child: addPlayerButton))
          ],
        ),
      )),
    );
  }
}

class _ListElem extends StatelessWidget {
  final String name;
  final int index;
  const _ListElem({Key? key,
    required this.name,
    required this.index
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Player Name',
              ),
            ),
          )),
          OutlinedButton(
            child: const Icon(Icons.delete),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _PlayerNames {
  static const MAX_PLAYER = 20;
  static const MIN_PLAYER = 2;
  static const DEFAULT_NAME = "";

  final names = <String>[DEFAULT_NAME, DEFAULT_NAME];

  add() {
    if (names.length < MAX_PLAYER) {
      names.add(DEFAULT_NAME);
    }
  }

  updateAt(String newName, int idx) {
    if (idx < names.length) {
      names[idx] = newName;
    }
  }

  removeAt(int idx) {
    if (names.length > MIN_PLAYER && idx < names.length) {
      names.removeAt(idx);
    }
  }

  List<_ListElem> toListElems() {
    final elem = <_ListElem>[];
    for (var i = 0; i < names.length; i++) {
      elem.add(_ListElem(name: names[i], index: i));
    }
    return elem;
  }

  Widget toListView() {
    final elems = toListElems();

    return Expanded(
      flex: 3,
        child: ListView.builder(
      itemCount: elems.length,
      itemBuilder: (_, i) => elems[i],
    ));
  }
}
