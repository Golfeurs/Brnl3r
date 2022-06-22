import 'package:brnl3r/models/players.dart';
import 'package:brnl3r/models/utils/tuples.dart';
import 'package:flutter/material.dart';

class MultiplierDialog extends StatefulWidget {
  final List<Player> selectablePlayer;
  final void Function(Tuple2<Player, int>) onFinish;
  const MultiplierDialog(
      {Key? key, required this.selectablePlayer, required this.onFinish})
      : super(key: key);

  @override
  State<MultiplierDialog> createState() => _MultiplierDialogState();
}

class _MultiplierDialogState extends State<MultiplierDialog> {
  static final values = () {
    final items = <int>[];
    for (int i = 2; i <= 20; i++) {
      items.add(i);
    }
    return items
        .map((e) => DropdownMenuItem<int>(value: e, child: Text('$e')))
        .toList();
  }.call();

  late List<DropdownMenuItem<Player>> players;
  late Player selected;
  var multiplier = values.first.value!;

  @override
  void initState() {
    selected = widget.selectablePlayer.first;
    players = widget.selectablePlayer
        .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Multiplier Selection'),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            DropdownButton<Player>(
              items: players,
              onChanged: (x) => setState(() => selected = x ?? selected),
              value: selected,
            ),
            DropdownButton<int>(
              items: _MultiplierDialogState.values,
              onChanged: (x) => setState(() => multiplier = x ?? multiplier),
              value: multiplier,
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () {
          widget.onFinish(Tuple2(selected,multiplier));
          Navigator.pop(context);
        }, child: const Text('OK'))
      ],
    );
  }
}
