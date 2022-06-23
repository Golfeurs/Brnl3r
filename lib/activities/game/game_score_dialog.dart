import 'package:brnl3r/models/game_state.dart';
import 'package:flutter/material.dart';

class GameScoreDialog extends StatelessWidget {
  final GameState gameState;
  const GameScoreDialog({Key? key, required this.gameState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    gameState.gameScoreBoard.forEach((p, s) {
      rows..add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
        child: Row(children: [
          Expanded(flex:3, child: Text(p.name)),
          const Expanded(flex: 1,child: Text('|'),) ,
          Expanded(flex: 2, child: Text('$s')),
          const Spacer()
        ]),
      ))..add(const Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
        child: Divider(),
      ));
    });

    return SimpleDialog(title: const Text('Game Score'), children:rows..removeLast());
  }
}
