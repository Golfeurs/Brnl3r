import 'package:brnl3r/activities/default_rule_dialogs/multiplier_dialog.dart';
import 'package:brnl3r/models/play_card.dart';
import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/rules/rules.dart';

class DefaultRule extends Rules {
  static final _instance = DefaultRule._();

  DefaultRule._();

  /// return singleton instance
  factory DefaultRule() {
    return _instance;
  }

  @override
  void updatedGameState(GameState gameState) {
    final card = gameState.topCard;
    if (card != null) {
      if (gameState.isShadow) {
        _dispatchShadow(card, gameState);
      } else {
        _dispatchStandard(card, gameState);
      }
    }
  }

  _dispatchStandard(PlayCard card, GameState gameState) {
    gameState.currentAction = standardRuleText[card.order];
    switch (card.order) {
      case Order.two:
      case Order.three:
      case Order.four:
      case Order.five:
      case Order.j:
      case Order.q:
      case Order.k:
      case Order.a:
        gameState.roundNeedScoreBoard = true;
        break;
      case Order.joker:
        gameState.makePlayAgain();
        gameState.makeNextShadow();
        break;
      case Order.seven:
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, -1, 1);
        break;
      case Order.eight:
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, 0, 1);
        gameState.makeNextShadow();
        break;
      case Order.nine:
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, 1, 1);
        break;
      case Order.ten:
        gameState.contextualRoundDialog = MultiplierDialog(
            selectablePlayer: gameState.otherPlayers,
            onFinish: (t) => gameState.addBinding(
                DrinkBindings(t.e2, {t.e1, gameState.currentPlayer})));
        break;
      default:
        break;
    }
  }

  _dispatchShadow(PlayCard card, GameState gameState) {
    gameState.currentAction = shadowRuleText[card.order];
    switch (card.order) {
      case Order.two:
      case Order.three:
      case Order.four:
      case Order.five:
      case Order.j:
      case Order.q:
      case Order.k:
      case Order.a:
        gameState.roundNeedScoreBoard = true;
        break;
      case Order.seven:
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, -2, 1);
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, -1, 1);
        break;
      case Order.eight:
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, 0, 4);
        gameState.makeNextShadow();
        gameState.makeNextShadow();
        break;
      case Order.nine:
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, -2, 1);
        gameState.addScoreToPlayerWithOffset(gameState.currentPlayer, -1, 1);
        break;
      case Order.ten:
        gameState.addBinding(DrinkBindings.bindingFromRandom(
            5, gameState.currentPlayer, gameState.otherPlayers, 0.5));
        break;
      case Order.joker:
        gameState.makePlayAgain();
        gameState.makeNextShadow();
        gameState.makeNextShadow();
        break;
      default:
        break;
    }
  }

  static const standardRuleText = <Order, String>{
    Order.two: """
Le tireur pense a un mot dans une chason. Les autres doivent donner une chanson dont les paroles contiennent le mot.
2 gorgés pour ceux qui ne trouvent pas. 5 pour le tireur si il a fait une erreur.
""",
    Order.three: """
Le tireur dois repondre aux questions d'une carte de trivial poursuite (ou autre).
Distribue 2 gorgées par bonne réponses, ou cul sec s'il n'en donne aucune.
""",
    Order.four: """
Seul le tireur reste dans la pièce. Il rempli 1 shot de vodka et le reste de shot d'eau, un shot par joueur.
Les joueurs reviennent dans la pièce et prennent aléatoirement un shot (sans le sentir). Cul sec! 
Le but est de deviner qui a eu la vodka. Ceux qui ont deviné distribuent deux gorgées.
""",
    Order.five: """
La personne avec le moins dans son verre cul sec.
""",
    Order.six: """
Le tireur invente une nouvelle règle (elle peut ètre valable toute la partie).
""",
    Order.seven: """
Le joueur à la gauche du tireur se rince le gosier (une gorgées).
""",
    Order.eight: """
Le tireur boit une gorgée. La prochaine carte est *SHADOW*.
""",
    Order.nine: """
Les 2 joueurs a droite du tireur rince leurs pintes (une gorgées).
""",
    Order.ten: """
Le tireur décide d'un multiplicateur et se lie à un joueur.
Le premier des deux qui boit multiplie le nombre de gorgées par le multiplicateur.
""",
    Order.j: """
Feuille-cailloux-ciseaux/shi-fu-mi/ntm entre le tireur et les joueurs. 
2 gorgées pour le perdant. 
""",
    Order.q: """
Le tireur dis un mot. Le joeur suivant répète les mots dit précédemment et un nouveau mot.
Ainsi de suite jusqu'à une erreur. Le joueur aillant commit une faute boit autant de gorgées qu'il y a eut de mots.
""",
    Order.k: """
Le tireur distribue 5 gorgées.
""",
    Order.a: """
Le tireur fait faire un cul sec, ou..., peut le jouer un quite ou double au shifumi avec un joueur de son choix.
#koudurSiTuPerds
""",
    Order.joker: """
Le tireur rejoue. Sa prochaine carte est *SHADOW*.
"""
  };

  static const shadowRuleText = <Order, String>{
    Order.two: """
Le tireur décide rapidement d'un mot. Les joeurs ont 1min. pour trouver le plus de chason possible contentant le mots.
Si égalité shifumi. Les perdant boivent autant de gorgées que de chanson (min. 1).
""",
    Order.three: """
Le tireur répond au question d'une carte de trivial poursuite (ou autre). Il boit 2 gorgées par réponse fausse.
Si la carte entière est correct, les autres joueurs boivent 5 gorgées.
""",
    Order.four: """
*SHADOW* Seul le tireur reste dans la pièce. Il rempli 1 shot d'EAU et le reste de shot de VODKA, un shot par joueur.
Les joueurs reviennent dans la pièce et prennent aléatoirement un shot (sans le sentir). Cul sec! 
Le but est de deviner qui a eu l'EAU. Ceux qui ont deviné distribuent deux gorgées.
""",
    Order.five: """
La personne avec le plus dans son verre cul sec.
""",
    Order.six: """
Les autres joueurs inventent une règle s'appliquant uniquement au tireur.
""",
    Order.seven: """
Les 2 joueurs à la gauche du tireur se murge le groin (une gorgées).
""",
    Order.eight: """
Le tireur boit 4 gorgée. Les deux prochaines cartes sont *SHADOW*.
""",
    Order.nine: """
Le joueur a droite du tireur, ainsi que vos daronnes boivent une gorgée.
""",
    Order.ten: """
Un multplicateur choisi aléatoirement entre 2 et 5 (compris) s'applique au tireur
et à 50% de chance de s'appliquer à chacun des joueurs.
""",
    Order.j: """
Feuille-cailloux-ciseaux/shi-fu-mi/ntm entre le tireur et les joueurs. 
2 gorgées pour le perdant. 5 gorgées à chaque égalité.
""",
    Order.q: """
Jeu du singe: Le tireur donne un thème. Les joueurs donne des mots du thème.
Le premier qui commet une faute, cul sec. (Sinon, jeu des mots "réplique golfique")
""",
    Order.k: """
Le tireur distribue autant de gorgées qu'il veut mais en bois le même nombre.
""",
    Order.a: """
Le tireur joue un cul sec au shifumi avec un joueur de son choix.
""",
    Order.joker: """
Le tireur rejoue.
Sa carte et celle du joueur suivant sont *SHADOW*.
"""
  };
}
