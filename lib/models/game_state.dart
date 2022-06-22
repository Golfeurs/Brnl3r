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

  final ScoreBoard _gameScoreBoard = {};
  final _bindings = <DrinkBindings>[];

  // --- ROUND DATA ---
  /// Player who drinks in the current round
  final ScoreBoard _roundScoreBoard = {};
  var playAgain = false;

  GameState(this._players) {
    for (var p in _players) {
      _gameScoreBoard.putIfAbsent(p, () => 0);
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

  ScoreBoard _updateScoreBoard() {
    ScoreBoard summaryScoreBoard = {};

    _roundScoreBoard.forEach((p, s) {
      var score = s;
      if(score > 0){
        for (var b in _bindings) {
          if(b.contains(p)) {
            score = score * b.multiplier;
            b.setUsed();
          }
        }
        summaryScoreBoard.update(p, (_) => score, ifAbsent: () => score);
      }
    });

    summaryScoreBoard.forEach((p, s) {
      _gameScoreBoard.update(p, (v) => v + s);
    });
    // reset ROUND scoreboard
    _gameScoreBoard.forEach((p, _) {
      _roundScoreBoard.update(p, (_) => 0);
    });

    return summaryScoreBoard;
  }

  void _updateShadow() {
    if (shadowQueue.length > 1) {
      shadowQueue.removeAt(0);
    } else {
      shadowQueue[0] = false;
    }
  }

  /// remove and return old `DrinkBindings`
  List<DrinkBindings> _removeOldBindings() {
    final oldBindings = _bindings.where((b) => b.used).toList();
    final newList = _bindings.where((b) => b.notUsed);
    _bindings..clear()..addAll(newList);
    return oldBindings;
  }

  void addBinding(DrinkBindings db) => _bindings.add(db);

  Player getPlayerFromOffset(Player p, int offset) {
    final pidx = _players.indexOf(p);
    final size = _players.length;
    int newIdx = (pidx + (offset % size)) % size;
    return _players[newIdx];
  }

  /// advance to next round, reset action, scoard board
  ///
  /// Call at the end of a round
  RoundSummary? updateAndNextRound() {
    if (!isFinished) {
      _resetAction();
      final scoreboard = _updateScoreBoard();
      _cards.removeAt(0);
      final oldBindings = _removeOldBindings();
      _currRound = playAgain ? _currRound : (_currRound + 1) % _players.length;
      playAgain = false;
      _updateShadow();
      return RoundSummary(scoreboard, oldBindings);
    }
    return null;
  }

  bool get isFinished => _cards.isEmpty;

  Player get currentPlayer => _players[_currRound];

  void makeNextShadow() => shadowQueue.add(true);

  void makePlayAgain() => playAgain = true;
}

class DrinkBindings {
  /// Maps players with multipliers
  final int multiplier;
  final Set<Player> _players;
  bool _used = false;
 
  DrinkBindings(this.multiplier, this._players);

  bool get used => _used;

  bool get notUsed => !_used;

  void setUsed() => _used = true;

  bool contains(Player p) => _players.contains(p);
}

class RoundSummary {
  final ScoreBoard roundScoreboard;
  final List<DrinkBindings> _roundBindings;
  
  const RoundSummary(this.roundScoreboard, this._roundBindings);

  Map<Player, int> userToMultiplier() {
    final result = <Player, int>{};
    for (var b in _roundBindings) { 
      roundScoreboard.forEach((p, _) {
        if(b.contains(p)){
          result.update(p, (m) => b.multiplier * m, ifAbsent: () => b.multiplier);
        }
      });
    }
    return result;
  }

  bool isNeeded() {
    roundScoreboard.removeWhere((_, value) => value <= 0);
    return roundScoreboard.isNotEmpty;
  }
}