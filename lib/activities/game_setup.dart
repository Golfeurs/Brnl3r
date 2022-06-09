import 'package:brnl3r/activities/game.dart';
import 'package:brnl3r/models/players.dart';
import 'package:flutter/material.dart';

/// Widget activity to setup the game
class GameSetup extends StatefulWidget {
  const GameSetup({Key? key}) : super(key: key);

  @override
  State<GameSetup> createState() => _GameSetupState();

}

class _GameSetupState extends State<GameSetup> {
  final playerNames = _PlayerNames();

  @override
  Widget build(BuildContext context) {
    _submit() {
      var players = playerNames.toPlayers();

      // check that all players are valids
      if(players.fold<bool>(true, (prev, player) => prev && player.isValid)){
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Game(players: players)));
      }
    }

    final addPlayerButton = OutlinedButton(
        onPressed: () {
          setState(() {
            playerNames.add();
          });
        },
        child: const Icon(Icons.add));

    playerCount() {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Text(
            'Number of players : ${playerNames.count}',
            style: Theme.of(context).textTheme.headlineSmall,
          ));
    }

    playerListView() {
      final listElems = playerNames.toListElems(
          (i) => setState(() => playerNames.removeAt(i)),
          (i, value) => playerNames.updateAt(i, value));

      return Expanded(
          flex: 3,
          child: ListView.builder(
              itemCount: listElems.length,
              itemBuilder: (_, i) => listElems[i]));
    }

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
            playerCount(),
            const Divider(),
            playerListView(),
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
  final void Function(int) onDelete;
  final void Function(int, String) onUpdate;
  const _ListElem(
      {Key? key,
      required this.name,
      required this.index,
      required this.onDelete,
      required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = name;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
              controller: controller,
              onChanged: (value) => onUpdate(index, value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Player Name',
              ),
            ),
          )),
          OutlinedButton(
            onPressed: () => onDelete(index),
            child: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }
}

class _PlayerNames {
  static const maxPlayer = 20;
  static const minPlayer = 2;
  static const defaultName = "";

  final names = <String>[defaultName, defaultName];

  int get count {
    return names.length;
  }

  void add() {
    if (names.length < maxPlayer) {
      names.add(defaultName);
    }
  }

  void updateAt(int idx, String newName) {
    if (idx < names.length) {
      names[idx] = newName;
    }
  }

  void removeAt(int idx) {
    if (names.length > minPlayer && idx < names.length) {
      names.removeAt(idx);
    }
  }

  List<_ListElem> toListElems(
      void Function(int) onDelete, void Function(int, String) onUpdate) {
    final elem = <_ListElem>[];
    for (var i = 0; i < names.length; i++) {
      elem.add(_ListElem(
          name: names[i], index: i, onDelete: onDelete, onUpdate: onUpdate));
    }
    return elem;
  }

  List<Player> toPlayers() {
    var players = <Player>[];
    for (var i = 0; i < names.length; i++) {
      players.add(Player(i, names[i]));
    }
    return players;
  }
}
