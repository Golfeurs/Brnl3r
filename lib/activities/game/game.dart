import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/players.dart';
import 'package:brnl3r/models/rules/default_rule.dart';
import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  final List<Player> players;
  const Game({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final canLeave = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Stop Branling?'),
              content: const Text('Do you really want to leave?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'yes...',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('NO!'),
                ),
              ],
            ),
          );
          return canLeave ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Playing BRNL3R'),
          ),
          body: GameView(
            onFinish: () => Navigator.pop(context),
            players: players,
          ),
        ));
  }
}

class GameView extends StatefulWidget {
  final void Function() onFinish;
  final List<Player> players;

  const GameView({Key? key, required this.onFinish, required this.players})
      : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  // ignore: prefer_typing_uninitialized_variables
  late final GameState _gameState;

  @override
  void initState() {
    _gameState = GameState(widget.players);
    DefaultRule().updatedGameState(_gameState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CardView(
        gameState: _gameState,
        onCardTapped: () => setState(() {
              _gameState.updateAndNextRound();
              if (_gameState.isFinished) {
                widget.onFinish();
              }
              DefaultRule().updatedGameState(_gameState);
            }));
  }
}

class CardView extends StatelessWidget {
  final GameState gameState;
  final void Function() onCardTapped;

  static final color1 = Colors.grey.shade900;
  static const color2 = Colors.white;

  Color get textColor => !gameState.isShadow ? color1 : color2;
  Color get bgColor => gameState.isShadow ? color1 : color2;

  const CardView(
      {Key? key, required this.gameState, required this.onCardTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: InkWell(
        onTap: onCardTapped,
        child: Center(
            child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  "Au tour de : ${gameState.currentPlayer.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: textColor),
                ))),
            Expanded(
                flex: 1,
                child: Center(
                    child: Text(
                  gameState.topCard.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50, color: textColor),
                ))),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 30.0),
                  child: Text(
                    gameState.currentAction.toString(),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, height: 1.5, color: textColor),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
