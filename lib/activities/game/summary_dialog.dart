import 'package:brnl3r/models/game_state.dart';
import 'package:flutter/material.dart';

void showSummaryDialog(BuildContext context, RoundSummary? roundSummary) async {
  if (roundSummary != null && roundSummary.isNeeded()) {
    final multipliers = roundSummary.userToMultiplier();
    final scoreTexts = <Widget>[];
    roundSummary.roundScoreboard.forEach((p, s) {
      final m = multipliers[p]?.toString();
      final mText = m == null ? '' : '(${m}x)';
      scoreTexts.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
        child:
            Text('${p.name} : $s $mText', style: const TextStyle(fontSize: 15)),
      ));
    });

    showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              title: const Text('Round Summary'),
              children: scoreTexts,
            ));
  }
}
