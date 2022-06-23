import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/players.dart';
import 'package:flutter/material.dart';

class GameScoreDialog extends StatelessWidget {
  final GameState gameState;
  const GameScoreDialog({Key? key, required this.gameState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rows = <TableRow>[];
    gameState.gameScoreBoard.forEach((p, s) {
      rows.add(TableRow(children: [Text(p.name), const Text(':'), Text('$s'), const Text('')]));
    });

    return SimpleDialog(title: const Text('Game Score'), children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: Table(columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(5),
        }, children: rows),
      )
    ]);
  }
}
