import 'package:brnl3r/models/play_card.dart';
import 'package:brnl3r/models/players.dart';
import 'package:brnl3r/models/scoreboard.dart';
import 'package:flutter/material.dart';

class GameState {
  // --- GAME DATA ---
  final List<PlayCard> _cards =PlayCard.cards()..shuffle();
  final List<Player> _players;
  int _currRound = 0;
  String? currentAction;

  final shadowQueue = [false];

  final ScoreBoard _gameScoreBoard = {};
  final _bindings = <DrinkBindings>[];

  // --- ROUND DATA ---
  /// Player who drinks in the current round
  final ScoreBoard _roundScoreBoard = {};
  Widget? _contextualRoundDialog;
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
      _contextualRoundDialog = null;
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

  Future<void> showContextualDialog(BuildContext context) async {
    Widget? dialog = _contextualRoundDialog;
    if(dialog != null){
      await showDialog(context: context, builder: (_) => dialog);
    }
  }

  bool get isFinished => _cards.isEmpty;

  Player get currentPlayer => _players[_currRound];

  List<Player> get players => List.of(_players);

  List<Player> get otherPlayers => List.of(_players)..remove(currentPlayer);

  void makeNextShadow() => shadowQueue.add(true);

  void makePlayAgain() => playAgain = true;

  ScoreBoard get gameScoreBoard => Map.of(_gameScoreBoard);

  set contextualRoundDialog(Widget contextualRoundDialog) {
    if(_contextualRoundDialog != null) { return; }

    _contextualRoundDialog = contextualRoundDialog;
  }
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