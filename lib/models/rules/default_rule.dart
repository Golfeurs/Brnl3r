import 'package:brnl3r/models/play_card.dart';
import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/rules/rules.dart';

class DefaultRule extends Rules {
  @override
  void updatedGameState(PlayCard card, GameState gameState) {
    if (gameState.isShadow) {
      _dispatchShadow(card, gameState);
    } else {
      _dispatchStandard(card, gameState);
    }
  }

  _dispatchStandard(PlayCard card, GameState gameState) {
    switch (card.order) {
      case Order.eight: gameState.makeNextShadow();
      break;
      default:
        break;
    }
  }

  _dispatchShadow(PlayCard card, GameState gameState) {
    switch (card.order) {
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
Le joueur à la gauche du tireur se rince le gosier.
""",
Order.eight: """
Le tireur boit une gorgée. La prochaine carte est *SHADOW*.
""",
Order.nine: """
Le joueur a droite du tireur, ainsi que vos daronnes boivent une gorgée.
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
  };
}
