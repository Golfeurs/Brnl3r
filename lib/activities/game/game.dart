import 'package:brnl3r/activities/game/game_score_dialog.dart';
import 'package:brnl3r/activities/game/score_write_dialog.dart';
import 'package:brnl3r/activities/game/summary_dialog.dart';
import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/players.dart';
import 'package:brnl3r/models/rules/default_rule.dart';
import 'package:brnl3r/models/scoreboard.dart';
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
        child: GameView(
          onFinish: () => Navigator.pop(context),
          players: players,
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

class _GameViewState extends State<GameView>
    with SingleTickerProviderStateMixin {
  // ignore: prefer_typing_uninitialized_variables
  late final GameState _gameState;

  late AnimationController _slideAnimationController;

  @override
  void initState() {
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimationController.forward();
    _gameState = GameState(widget.players);
    DefaultRule().updatedGameState(_gameState);

    super.initState();
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  Future<void> setStateForNextRound() async {
    await _gameState.showContextualDialog(context);

    final scoreThisRound = await showDialog<ScoreBoard>(
        context: context,
        builder: (ctx) {
          return TallyDialog(
              title: 'Players ScoreBoard', players: widget.players);
        });

    setState(() {
      _gameState.addRoundScoreBoard(scoreThisRound ?? {});

      final roundSummary = _gameState.updateAndNextRound();

      showSummaryDialog(context, roundSummary);

      // GAME FINISHED ?
      if (_gameState.isFinished) {
        widget.onFinish();
      }

      // UPDATE GAME STATE FROM RULES
      DefaultRule().updatedGameState(_gameState);

      // ANIMATIONS
      _slideAnimationController.reset();
      _slideAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playing BRNL3R'),
        actions: [
          TextButton(onPressed: () {
            showDialog(context: context, builder: (_) => GameScoreDialog(gameState: _gameState));
          }, child: const Icon(Icons.scoreboard))
        ],
      ),
      body: CardView(
        gameState: _gameState,
        onCardTapped: () => setStateForNextRound(),
        animationController: _slideAnimationController,
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final AnimationController animationController;

  final GameState gameState;
  final void Function() onCardTapped;

  static final color1 = Colors.grey.shade900;
  static const color2 = Colors.white;

  Color get textColor => !gameState.isShadow ? color1 : color2;
  Color get bgColor => gameState.isShadow ? color1 : color2;

  const CardView(
      {Key? key,
      required this.gameState,
      required this.onCardTapped,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return slideTransitionBuilder(Container(
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
                  ),
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    gameState.topCard.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50, color: textColor),
                  ),
                )),
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
    ));
  }

  SlideTransition slideTransitionBuilder(Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: const Offset(3, 0), end: Offset.zero)
            .animate(animationController),
        child: child);
  }
}
