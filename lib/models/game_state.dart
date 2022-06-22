import 'package:brnl3r/models/play_card.dart';
import 'package:brnl3r/models/players.dart';
import 'package:brnl3r/models/scoreboard.dart';

class GameState {
  // --- GAME DATA ---
  final List<PlayCard> _cards = PlayCard.cards()..shuffle();
  final List<Player> _players;
  int _currRound = 0;
  String? currentAction;

  final shadowQueue = [false];

  final ScoreBoard gameScoreBoard = {};
  final bindings = <DrinkBindings>[];

  // --- ROUND DATA ---
  /// Player who drinks in the current round
  final ScoreBoard _roundScoreBoard = {};
  var playAgain = false;

  GameState(this._players) {
    for (var p in _players) {
      gameScoreBoard.putIfAbsent(p, () => 0);
      _roundScoreBoard.putIfAbsent(p, () => 0);
    }
  }

  PlayCard? get topCard => _cards.isEmpty ? null : _cards.first;

  bool get isShadow => shadowQueue.first;

  void addRoundScoreBoard(ScoreBoard that) {
    that.forEach((p, s) {
      _roundScoreBoard.update(p, (value) => value + s);
    });
  }

  void _resetAction() => currentAction = null;

  void _updateScoreBoard() {
    // update GAME scoreboard
    _roundScoreBoard.forEach((p, s) {
      // TODO : check bindings ...
      gameScoreBoard.update(p, (v) => v + s);
    });
    // reset ROUND scoreboard
    gameScoreBoard.forEach((p, _) {
      _roundScoreBoard.update(p, (_) => 0);
    });
  }

  _updateShadow() {
    if (shadowQueue.length > 1) {
      shadowQueue.removeAt(0);
    } else {
      shadowQueue[0] = false;
    }
  }

  /// advance to next round, reset action, scoard board
  ///
  /// Call at the end of a round
  void updateAndNextRound() {
    if (!isFinished) {
      _resetAction();
      _updateScoreBoard();
      _cards.removeAt(0);
      _currRound = playAgain ? _currRound : (_currRound + 1) % _players.length;
      playAgain = false;
      _updateShadow();
    }
  }

  bool get isFinished => _cards.isEmpty;

  Player get currentPlayer => _players[_currRound];

  void makeNextShadow() => shadowQueue.add(true);

  void makePlayAgain() => playAgain = true;
}

class DrinkBindings {
  /// Maps players with multipliers
  final Map<Player, int> multipliers;

  const DrinkBindings(this.multipliers);

  bool contains(Player player) => multipliers.containsKey(player);
}
