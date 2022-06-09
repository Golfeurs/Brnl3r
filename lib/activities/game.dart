import 'package:brnl3r/models/players.dart';
import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  final List<Player> players;
  const Game({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async { 
      final canLeave = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Stop Branling?'),
          content: const Text('Do you really want to leave?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true) ,
              child: Text('yes...', style: Theme.of(context).textTheme.bodySmall,),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('NO!'),
            ),
          ],
        ),
      );
      return canLeave ?? false;
    },

    child: Scaffold(
      appBar: AppBar(
        title: const Text('Playing BRNL3R'),
      ),
      body: Column(
        children: players.map((p) => Text(p.toString())).toList(),
      ),
    ));
  }
}
