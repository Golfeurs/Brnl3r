import 'package:brnl3r/models/play_card.dart';
import 'package:brnl3r/models/players.dart';
import 'package:brnl3r/models/scoreboard.dart';

class GameState {
  // --- GAME DATA ---
  final List<PlayCard> _cards = PlayCard.cards..shuffle();
  final List<Player> _players;
  int _currRound = 0;
  String? currentAction;

  bool _isShadow = false;
  bool nextIsShadow = false;

  final ScoreBoard gameScoreBoard = {};
  final bindings = <DrinkBindings> [];

  // --- ROUND DATA ---
  /// Player who drinks in the current round
  final ScoreBoard roundScoreBoard = {};

  GameState(
    this._players
  ) {
    for (var p in _players) {
      gameScoreBoard.putIfAbsent(p, () => 0);
      roundScoreBoard.putIfAbsent(p, () => 0);
    }
  }

  PlayCard? get topCard => _cards.isEmpty ? null : _cards.first;

  bool get isShadow => _isShadow;

  void _resetAction() => currentAction = null;

  void _updateScoreBoard() {
    // update GAME scoreboard
    roundScoreBoard.forEach((p, s) {
      gameScoreBoard.update(p, (v) => v + s);
    });
    // reset ROUND scoreboard
    gameScoreBoard.forEach((p, _) {
      roundScoreBoard.update(p, (_) => 0);
    });
  }

  _updateShadow() {
    _isShadow = nextIsShadow;
    nextIsShadow = false;
  }

  /// advance to next round, reset action, scoard board
  /// 
  /// Call at the end of a round
  void updateAndNextRound() {
    if(!isFinished) {
      _resetAction();
      _updateScoreBoard();
      _cards.removeAt(0);
      _currRound = (_currRound + 1) % _players.length;
      _updateShadow();
    }
  }

  bool get isFinished => _cards.isEmpty;

  void makeNextShadow() => nextIsShadow = true;
}

class DrinkBindings {
  /// Maps players with multipliers
  final Map<Player, int> multipliers;
  
  const DrinkBindings(this.multipliers);

  bool contains(Player player) => multipliers.containsKey(player);
}