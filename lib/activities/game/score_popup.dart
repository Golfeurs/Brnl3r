import 'package:brnl3r/models/scoreboard.dart';
import 'package:flutter/material.dart';

import '../../models/players.dart';

class TallyDialog extends StatefulWidget {
  final int limit;
  final List<Player> players;
  
  const TallyDialog({Key? key, required this.players, this.limit = 10000}) : super(key: key);


  @override
  State<TallyDialog> createState() => _TallyDialogState();
}

class _TallyDialogState extends State<TallyDialog> {
  void onFinish() {
    Navigator.of(context).pop(_playersToScore);
  }

  final ScoreBoard _playersToScore = {};
  late SnackBar snackBar;

  @override
  void initState() {
    // setup map of player to score
    for (var element in widget.players) {
      _playersToScore.putIfAbsent(element, () => 0);
    }
    snackBar = SnackBar(
      content: Text(
        "Total cannot be more than ${widget.limit}",
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return playerCounter(context, MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height);
  }

  StatefulBuilder playerCounter(
      BuildContext context, double screenWidth, double screenHeight) {
    final players = _playersToScore.entries.toList();
    final sum = _playersToScore.values.reduce((value, element) => value + element);
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Player tally'),
        content: SizedBox(
          height: screenHeight * .5,
          width: screenWidth * .7,
          child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (_, index) => SizedBox(
              height: screenHeight / 20,
              child: Row(
                children: playerRowBuilder(players[index]),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Text("Total : ${sum.toString()}"),
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              if(sum > widget.limit) {
                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                () {
                  onFinish();
                }.call();
              }
            },
          ),
        ],
      );
    });
  }

  List<Widget> playerRowBuilder(MapEntry<Player, int> playerData) {
    return [
      Expanded(flex: 4, child: Text(playerData.key.name)),
      Expanded(
        flex: 2,
        child: IconButton(
          onPressed: () => _scoreButtonCallback(playerData.key, -1),
          icon: Icon(
            Icons.remove_circle,
            color: Colors.redAccent[400],
          ),
        ),
      ),
      Expanded(flex: 1, child: Text(playerData.value.toString())),
      Expanded(
        flex: 1,
        child: IconButton(
          onPressed: () => _scoreButtonCallback(playerData.key, 1),
          icon: Icon(
            Icons.add_circle,
            color: Colors.greenAccent[400],
          ),
        ),
      )
    ];
  }

  void _scoreButtonCallback(Player player, int score) {
    setState(() {
      _playersToScore.update(player, (value) => (value + score < 0) ? 0 : value + score);
    });
  }
}
