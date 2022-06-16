import 'package:brnl3r/models/game_state.dart';
import 'package:brnl3r/models/play_card.dart';

abstract class Rules {
  void updatedGameState(PlayCard card, GameState gameState);
}

///
/// *** THIS IS AN EXAMPLE FOR USAGE OF RULE ***
///

// class ExampleRule extends Rules {
//   @override
//   void updatedGameState(PlayCard card, GameState gameState) {
//     switch (card.kind) {
//       case Kind.spade:
//         if(gameState.isShadow) {
//           _dispatchSpadeShadow(card, gameState); 
//         } else {
//           _dispatchSpade(card, gameState);
//         }
//         break;
//       case Kind.club:
//         if(gameState.isShadow) {
//           _dispatchClubShadow(card, gameState);
//         } else {
//           _dispatchClub(card, gameState);
//         }
//         break;
//       case Kind.heart:
//         if(gameState.isShadow) {
//           _dispatchHeartShadow(card, gameState);
//         } else {
//           _dispatchHeartShadow(card, gameState);
//         }
//         break;
//       case Kind.diamond:
//         if(gameState.isShadow) {
//           _dispatchDiamondShadow(card, gameState);
//         } else {
//           _dispatchDiamond(card, gameState);
//         }
//         break;
//       default:
//     }
//   }

//   //==============================================
//   // ---- SPADE ----
//   //==============================================

//   void _dispatchSpade(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         // TODO: Handle this case.
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   void _dispatchSpadeShadow(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         // TODO: Handle this case.
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   //==============================================
//   // ---- CLUB ----
//   //==============================================

//   void _dispatchClub(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   void _dispatchClubShadow(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   //==============================================
//   // ---- HEART ----
//   //==============================================

//   void _dispatchHeart(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   void _dispatchHeartShadow(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   //==============================================
//   // ---- DIAMOND ----
//   //==============================================

//   void _dispatchDiamond(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }

//   void _dispatchDiamondShadow(PlayCard card, GameState gameState) {
//     switch (card.order) {
//       case Order.two:
//         break;
//       case Order.three:
//         // TODO: Handle this case.
//         break;
//       case Order.four:
//         // TODO: Handle this case.
//         break;
//       case Order.five:
//         // TODO: Handle this case.
//         break;
//       case Order.six:
//         // TODO: Handle this case.
//         break;
//       case Order.seven:
//         // TODO: Handle this case.
//         break;
//       case Order.eight:
//         // TODO: Handle this case.
//         break;
//       case Order.nine:
//         // TODO: Handle this case.
//         break;
//       case Order.ten:
//         // TODO: Handle this case.
//         break;
//       case Order.j:
//         // TODO: Handle this case.
//         break;
//       case Order.q:
//         // TODO: Handle this case.
//         break;
//       case Order.k:
//         // TODO: Handle this case.
//         break;
//       case Order.a:
//         // TODO: Handle this case.
//         break;
//       case Order.joker:
//         // TODO: Handle this case.
//         break;
//       default:
//         break;
//     }
//   }
// }