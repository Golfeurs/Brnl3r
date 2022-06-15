import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/play_card.dart';

abstract class Rules {
  GameState updatedGameState(PlayCard card, GameState gameState);
}