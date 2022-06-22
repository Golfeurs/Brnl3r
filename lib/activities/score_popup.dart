import 'package:flutter/material.dart';

class TallyDialog extends StatefulWidget {
  TallyDialog({Key? key, required this.limit}) : super(key: key);

  int limit = 5;

  @override
  State<TallyDialog> createState() => _TallyDialogState();
}

class _TallyDialogState extends State<TallyDialog> {
  //need to get player list and player scores
  final List<String> _players = ["Player 1", "Player 2", "Player 3", "Roméo"];
  final List<int> _playerCounters = [0, 0, 0, 0];
  int _sum = 0;
  int limit = 0;
  late SnackBar snackBar;

  @override
  void initState() {
    limit = widget.limit;
    snackBar = SnackBar(
      content: Text(
        "Total cannot be more than $limit",
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
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Player tally'),
        content: SizedBox(
          height: screenHeight * .5,
          width: screenWidth * .7,
          child: ListView.builder(
            itemCount: _players.length,
            itemBuilder: (_, index) => SizedBox(
              height: screenHeight / 20,
              child: Row(
                children: playerRowBuilder(index),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Text("Total : ${_sum.toString()}"),
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              _sum > limit
                  ? ScaffoldMessenger.of(context).showSnackBar(snackBar)
                  : () {
                      Navigator.of(context).pop();
                      returnScore();
                    }.call();
            },
          ),
        ],
      );
    });
  }

  List<Widget> playerRowBuilder(int index) {
    return [
      Expanded(flex: 4, child: Text(_players[index])),
      Expanded(
        flex: 2,
        child: IconButton(
          onPressed: () => _scoreButonCallback(index, -1),
          icon: Icon(
            Icons.remove_circle,
            color: Colors.redAccent[400],
          ),
        ),
      ),
      Expanded(flex: 1, child: Text(_playerCounters[index].toString())),
      Expanded(
        flex: 1,
        child: IconButton(
          onPressed: () => _scoreButonCallback(index, 1),
          icon: Icon(
            Icons.add_circle,
            color: Colors.greenAccent[400],
          ),
        ),
      )
    ];
  }

  void _scoreButonCallback(int index, int score) {
    int newScore = _playerCounters[index] + score;
    setState(() {
      if (newScore >= 0) {
        _playerCounters[index] = newScore;
      }
      _sum = _playerCounters.reduce((a, b) => a + b);
    });
  }

  Map<String, int> returnScore() {
    Map<String, int> scoreboard = {};
    for (var i = 0; i < _players.length; i++) {
      scoreboard[_players[i]] = _playerCounters[i];
    }
    return scoreboard;
  }
}
