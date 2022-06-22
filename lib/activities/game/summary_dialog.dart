import 'package:brnl3r/models/game_state.dart';
import 'package:flutter/material.dart';

void showSummaryDialog(BuildContext context, RoundSummary? roundSummary) async {
  if (roundSummary != null && roundSummary.isNeeded()) {
    final multipliers = roundSummary.userToMultiplier();
    final scoreTexts = <TableRow>[];
    roundSummary.roundScoreboard.forEach((p, s) {
      final m = multipliers[p]?.toString();
      final mText = m == null ? '' : '(${m}x)';
      const textStyle = TextStyle(fontSize: 15);
      scoreTexts.add(
        TableRow(
          children: [
            Text(p.name, style: textStyle, ),
            const Text(':', style: textStyle),
            Text('$s', style: textStyle),
            Text(mText, style: textStyle),
          ],
        ),
      );
    });

    showDialog(
        context: context,
        builder: (_) => SimpleDialog(
              title: const Text('Round Summary'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(50),
                      1: FixedColumnWidth(10),
                      2: FixedColumnWidth(20),
                      3: FixedColumnWidth(20),
                    },
                    children: scoreTexts
                  ),
                )
              ],
            ));
  }
}
